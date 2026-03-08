import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:s_factory/features/qr/qr_generator.dart';
import '../../../dataconnect_generated/generated.dart';

import 'package:s_factory/features/machine/request_form_page.dart';
import 'package:s_factory/features/machine/add_routine_page.dart';

import '../../shared/widgets/nav_bar.dart';

class MachineDetailPage extends StatefulWidget {
  final Map<String, String> machineData;
  final String role; // Require the role argument

  const MachineDetailPage({
    super.key,
    required this.machineData,
    required this.role,
  });

  @override
  State<MachineDetailPage> createState() => _MachineDetailPageState();
}

class _MachineDetailPageState extends State<MachineDetailPage> {
  List<Map<String, dynamic>> _checklistItems = [];
  bool _routinesInitialized = false;
  bool _isSavingRoutines = false;

  late Future<
    QueryResult<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>
  >
  _routinesFuture;

  @override
  void initState() {
    super.initState();
    _loadRoutines();
  }

  void _loadRoutines() {
    setState(() {
      _routinesInitialized = false;
      _checklistItems.clear();
      _routinesFuture = ConnectorConnector.instance
          .getRoutinesByMachineId(machineId: widget.machineData['id']!)
          .execute();
    });
  }

  void _initRoutinesFromSnapshot(
    List<GetRoutinesByMachineIdRoutines> routines,
  ) {
    if (_routinesInitialized) return;
    _routinesInitialized = true;
    _checklistItems = routines
        .map(
          (r) => {
            'id': r.id,
            'title': r.title ?? 'No Title',
            'subtitle': r.description ?? '',
            'isDone': r.isCheck ?? false,
          },
        )
        .toList();
  }

  Future<void> _saveRoutines() async {
    setState(() => _isSavingRoutines = true);
    try {
      for (final item in _checklistItems) {
        await ConnectorConnector.instance
            .updateRoutine(id: item['id'], isCheck: item['isDone'])
            .execute();

        // Auto-create a RoutineLog for this check
        await ConnectorConnector.instance
            .createRoutineLog(
              title: 'Checked: ${item['title']}',
              isDone: item['isDone'],
              routineId: item['id'],
            )
            .execute();
      }
    } finally {
      if (mounted) setState(() => _isSavingRoutines = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.role == 'mechanic') {
      return _buildMechanicView(context);
    }

    return Scaffold(
      appBar: NavBar(title: widget.machineData['name']!, leadingText: 'Cancel'),
      body: FutureBuilder<QueryResult<GetMachineData, GetMachineVariables>>(
        future: widget.machineData['id'] == null
            ? null
            : ConnectorConnector.instance
                  .getMachine(id: widget.machineData['id']!)
                  .execute(),
        builder: (context, machineSnapshot) {
          if (machineSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (machineSnapshot.hasError) {
            return Center(child: Text('Error: ${machineSnapshot.error}'));
          }

          final machine = machineSnapshot.data?.data.machine;
          final name =
              machine?.name ?? widget.machineData['name'] ?? 'Unknown machine';
          final description =
              machine?.description ??
              widget.machineData['description'] ??
              'No description';
          final imageUrl =
              widget.machineData['imageUrl'] ??
              'https://via.placeholder.com/400x250?text=Machine';

          return FutureBuilder<
            QueryResult<
              GetRoutinesByMachineIdData,
              GetRoutinesByMachineIdVariables
            >
          >(
            future: _routinesFuture,
            builder: (context, routineSnapshot) {
              // Initialise local checklist state once
              if (routineSnapshot.hasData) {
                _initRoutinesFromSnapshot(routineSnapshot.data!.data.routines);
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Machine Image
                    Center(
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported, size: 100),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (widget.machineData['id'] != null)
                                _buildMachineQRCode(
                                  context,
                                  machineID: widget.machineData['id']!,
                                ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          const Text(
                            'รายละเอียดเครื่องจักร',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 30),
                          _buildActionButtons(context, name: name),

                          const SizedBox(height: 30),

                          // ── Routine Checklist Section ──
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Routine Checklist',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              if (_checklistItems.isNotEmpty)
                                _isSavingRoutines
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : TextButton.icon(
                                        onPressed: () async {
                                          await _saveRoutines();
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Checklist saved!',
                                                ),
                                                backgroundColor: Colors.green,
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.save_outlined,
                                          size: 18,
                                        ),
                                        label: const Text('Save'),
                                      ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          if (routineSnapshot.connectionState ==
                              ConnectionState.waiting)
                            const Center(child: CircularProgressIndicator())
                          else if (routineSnapshot.hasError)
                            Text(
                              'Error loading routines: ${routineSnapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            )
                          else if (_checklistItems.isEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Text(
                                'No routines yet. Tap "Add Routine Checklist" above to create one.',
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: List.generate(
                                  _checklistItems.length,
                                  (index) {
                                    final item = _checklistItems[index];
                                    final isLast =
                                        index == _checklistItems.length - 1;
                                    return Column(
                                      children: [
                                        CheckboxListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 4,
                                              ),
                                          title: Text(
                                            item['title'] as String,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          subtitle:
                                              (item['subtitle'] as String)
                                                  .isNotEmpty
                                              ? Text(
                                                  item['subtitle'] as String,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                )
                                              : null,
                                          value: item['isDone'] as bool,
                                          activeColor: Colors.indigo,
                                          checkboxShape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _checklistItems[index]['isDone'] =
                                                  value ?? false;
                                            });
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                        ),
                                        if (!isLast)
                                          const Divider(
                                            height: 1,
                                            indent: 16,
                                            endIndent: 16,
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMachineQRCode(BuildContext context, {String? machineID}) {
    return SizedBox(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.qr_code),
        label: Text("QR Code", style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          iconColor: Colors.black,
          minimumSize: const Size(120, 40),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  QRGeneratorPage(machineID: machineID as String),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMechanicView(BuildContext context) {
    return FutureBuilder<
      QueryResult<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>
    >(
      future: _routinesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error loading routines: ${snapshot.error}'),
            ),
          );
        }

        final routines = snapshot.data?.data.routines ?? [];

        // Initialize the local state from routines on first load
        if (_checklistItems.isEmpty && routines.isNotEmpty) {
          _checklistItems = routines
              .map(
                (r) => {
                  'id': r.id,
                  'title': r.title ?? 'No Title',
                  'subtitle': r.description ?? '',
                  'isDone': r.isCheck ?? false,
                },
              )
              .toList();
        }

        return Scaffold(
          backgroundColor:
              Colors.grey[50], // Soft background to make white containers pop
          appBar: AppBar(
            title: Text(widget.machineData['name']!),
            centerTitle: true,
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 90,
            leading: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    // Show saving indicator
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saving checklist...')),
                    );

                    // Update all checklist items in Data Connect
                    for (var item in _checklistItems) {
                      await ConnectorConnector.instance
                          .updateRoutine(
                            id: item['id'],
                            isCheck: item['isDone'],
                          )
                          .execute();

                      // Auto-create a RoutineLog for this check
                      await ConnectorConnector.instance
                          .createRoutineLog(
                            title: 'Checked: ${item['title']}',
                            isDone: item['isDone'],
                            routineId: item['id'],
                          )
                          .execute();
                    }

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checklist saved successfully!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error saving: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Box
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.machineData['imageUrl'] ?? '',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.machineData['description']!,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (_checklistItems.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: List.generate(_checklistItems.length, (
                          index,
                        ) {
                          final item = _checklistItems[index];
                          return _buildChecklistItem(
                            context,
                            index,
                            item['title'] as String,
                            item['subtitle'] as String,
                            isLast: index == _checklistItems.length - 1,
                          );
                        }),
                      ),
                    )
                  else
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'No checklist available for this machine.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChecklistItem(
    BuildContext context,
    int index,
    String title,
    String subtitle, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        CheckboxListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: subtitle.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                )
              : null,
          value: _checklistItems[index]['isDone'],
          activeColor: Colors.deepOrange,
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          onChanged: (bool? value) {
            setState(() {
              _checklistItems[index]['isDone'] = value ?? false;
            });
          },
          controlAffinity: ListTileControlAffinity.trailing,
        ),
        if (!isLast) const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  /// Builds different action buttons depending on the user's role (for non-mechanic users).
  Widget _buildActionButtons(BuildContext context, {String? name}) {
    if (widget.role == 'staff') {
      return Center(
        child: SizedBox(
          width: 250,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestFormPage(
                    machineName: name ?? widget.machineData['name']!,
                    machineID: widget.machineData['id']!,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.send),
            label: const Text(
              'ส่งคำร้องซ่อม/บำรุง',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      );
    } else if (widget.role == 'admin') {
      return Column(
        children: [
          Center(
            child: SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRoutinePage(
                        machineId: widget.machineData['id']!,
                        machineName: widget.machineData['name']!,
                      ),
                    ),
                  );
                  if (result == true && mounted) {
                    _loadRoutines();
                  }
                },
                icon: const Icon(Icons.checklist),
                label: const Text(
                  'Add Routine Checklist',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Fallback if role is unknown
    return const SizedBox.shrink();
  }
}
