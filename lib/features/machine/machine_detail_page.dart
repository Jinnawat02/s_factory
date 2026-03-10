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

  Future<QueryResult<GetMachineData, GetMachineVariables>>? _machineFuture;

  @override
  void initState() {
    super.initState();
    _loadMachine();
    _loadRoutines();
  }

  void _loadMachine() {
    _machineFuture = widget.machineData['id'] == null
        ? null
        : ConnectorConnector.instance
              .getMachine(id: widget.machineData['id']!)
              .execute();
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
    // if (widget.role == 'mechanic') {
    //   return _buildMechanicView(context);
    // }

    return Scaffold(
      appBar: NavBar(title: widget.machineData['name']!, leadingText: 'Cancel'),
      body: FutureBuilder<QueryResult<GetMachineData, GetMachineVariables>>(
        future: _machineFuture,
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
              'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=0D47A1&color=fff&size=200&bold=true';

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
                            'Machine Details',
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

                          if (widget.role == 'staff') ...[
                            const SizedBox(height: 30),
                            _buildActionButtons(context, name: name),
                          ],

                          // ── Routine Checklist Section ──
                          if (widget.role == 'mechanic' ||
                              widget.role == 'admin') ...[
                            const SizedBox(height: 30),
                            _buildRoutineChecklistSection(
                              context,
                              routineSnapshot,
                            ),
                          ],
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
              'Submit Request',
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
          if (widget.machineData['id'] != null) ...[
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _confirmDeleteMachine(context),
                  icon: const Icon(Icons.delete),
                  label: const Text(
                    'Delete Machine',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      );
    }

    // Fallback if role is unknown
    return const SizedBox.shrink();
  }

  Future<void> _confirmDeleteMachine(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Machine'),
        content: Text(
          'Are you sure you want to delete ${widget.machineData['name']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      try {
        await ConnectorConnector.instance
            .deleteMachine(id: widget.machineData['id']!)
            .execute();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Machine deleted successfully')),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting machine: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget _buildRoutineChecklistSection(
    BuildContext context,
    AsyncSnapshot<
      QueryResult<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>
    >
    routineSnapshot,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRoutineHeader(context),
        const SizedBox(height: 8),
        _buildRoutineContent(context, routineSnapshot),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildRoutineHeader(BuildContext context) {
    return Row(
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
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : TextButton.icon(
                  onPressed: () async {
                    await _saveRoutines();

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checklist saved!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.save_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
      ],
    );
  }

  Widget _buildRoutineContent(
    BuildContext context,
    AsyncSnapshot<
      QueryResult<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>
    >
    snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Text(
        'Error loading routines: ${snapshot.error}',
        style: const TextStyle(color: Colors.red),
      );
    }

    if (_checklistItems.isEmpty) {
      return Container(
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
      );
    }

    return _buildRoutineList();
  }

  Widget _buildRoutineList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(_checklistItems.length, (index) {
          final item = _checklistItems[index];
          final isLast = index == _checklistItems.length - 1;

          return Column(
            children: [
              CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                title: Text(
                  item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                subtitle: (item['subtitle'] as String).isNotEmpty
                    ? Text(
                        item['subtitle'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      )
                    : null,
                value: item['isDone'],
                activeColor: Colors.indigo,
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (value) {
                  setState(() {
                    _checklistItems[index]['isDone'] = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              if (!isLast) const Divider(height: 1, indent: 16, endIndent: 16),
            ],
          );
        }),
      ),
    );
  }
}
