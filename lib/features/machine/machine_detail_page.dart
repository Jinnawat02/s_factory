/// Screen displaying detailed information about a specific factory machine.
///
/// This page allows users to:
/// - View machine details (name, description, serial number).
/// - Submit repair requests (Staff).
/// - View and complete routine maintenance checklists (Mechanics and Admins).
/// - Update or Delete the machine (Admins).
/// - Generate and view the machine's QR code.
///
/// @author Jinnawat Janngam
import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:s_factory/features/qr/qr_generator.dart';
import '../../../dataconnect_generated/generated.dart';

import 'package:s_factory/features/machine/request_form_page.dart';
import 'package:s_factory/features/machine/add_routine_page.dart';

import '../../shared/widgets/nav_bar.dart';
import '../../shared/utils/snackbar_utils.dart';

import 'update_machine_page.dart';

/// A stateful widget that manages the display and interaction logic for machine details.
class MachineDetailPage extends StatefulWidget {
  /// Initial machine data passed from the list page.
  final Map<String, String> machineData;
  
  /// The user's role, which determines available actions on the page.
  final String role;

  /// Creates a [MachineDetailPage].
  const MachineDetailPage({
    super.key,
    required this.machineData,
    required this.role,
  });

  @override
  State<MachineDetailPage> createState() => _MachineDetailPageState();
}

class _MachineDetailPageState extends State<MachineDetailPage> {
  /// List of items for the routine maintenance checklist.
  List<Map<String, dynamic>> _checklistItems = [];
  
  /// Ensures checklist state is only initialized once from the snapshot.
  bool _routinesInitialized = false;
  
  /// Tracks if routine checklist changes are currently being saved.
  bool _isSavingRoutines = false;

  /// Future for fetching routine checklist items for this machine.
  late Future<
    QueryResult<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>
  >
  _routinesFuture;

  /// Future for fetching the latest machine details from the database.
  Future<QueryResult<GetMachineData, GetMachineVariables>>? _machineFuture;

  @override
  void initState() {
    super.initState();
    _loadMachine();
    _loadRoutines();
  }

  /// Initiates the fetch for complete machine details.
  void _loadMachine() {
    setState(() {
      _machineFuture = widget.machineData['id'] == null
          ? null
          : ConnectorConnector.instance
                .getMachine(id: widget.machineData['id']!)
                .execute();
    });
  }

  /// Initiates the fetch for the machine's routine checklist.
  void _loadRoutines() {
    setState(() {
      _routinesInitialized = false;
      _checklistItems.clear();
      _routinesFuture = ConnectorConnector.instance
          .getRoutinesByMachineId(machineId: widget.machineData['id']!)
          .execute();
    });
  }

  /// populates the local checklist state from the database snapshot.
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

  /// Saves the current state of the routine checklist back to the database.
  Future<void> _saveRoutines() async {
    setState(() => _isSavingRoutines = true);
    try {
      for (final item in _checklistItems) {
        await ConnectorConnector.instance
            .updateRoutine(id: item['id'], isCheck: item['isDone'])
            .execute();

        // Log the maintenance action for audit trails.
        await ConnectorConnector.instance
            .createRoutineLog(
              title: 'Checked: ${item['title']}',
              isDone: item['isDone'],
              routineId: item['id'],
            )
            .execute();
      }
      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Routines saved successfully');
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'Error saving routines: $e');
      }
    } finally {
      if (mounted) setState(() => _isSavingRoutines = false);
    }
  }

  /// Displays a confirmation dialog before deleting the machine.
  Future<void> _confirmDeleteMachine(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E22),
        title: const Text(
          'Delete Machine',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete this machine? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ConnectorConnector.instance
            .deleteMachine(id: widget.machineData['id']!)
            .execute();

        if (mounted) {
          SnackBarUtils.showSuccess(context, 'Machine deleted successfully');
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          SnackBarUtils.showError(context, 'Error deleting machine: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QueryResult<GetMachineData, GetMachineVariables>>(
      future: _machineFuture,
      builder: (context, machineSnapshot) {
        if (machineSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: NavBar(
              title: widget.machineData['name']!,
              leadingText: 'Cancel',
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (machineSnapshot.hasError) {
          return Scaffold(
            appBar: NavBar(
              title: widget.machineData['name']!,
              leadingText: 'Cancel',
            ),
            body: Center(child: Text('Error: ${machineSnapshot.error}')),
          );
        }

        final machine = machineSnapshot.data?.data.machine;
        final name =
            machine?.name ?? widget.machineData['name'] ?? 'Unknown machine';
        final description =
            machine?.description ??
            widget.machineData['description'] ??
            'No description';
        final imageUrl =
            machine?.imageUrl ??
            widget.machineData['imageUrl'] ??
            'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=0D47A1&color=fff&size=200&bold=true';
        final serialNumber =
            machine?.serialNumber ?? widget.machineData['serialNumber'];

        // Prepare updated data map for child screens (Update/Request).
        final currentMachineData = {
          ...widget.machineData,
          'name': name,
          'description': description,
          if (machine?.imageUrl != null) 'imageUrl': machine?.imageUrl,
          if (serialNumber != null) 'serialNumber': serialNumber,
        };

        return Scaffold(
          appBar: NavBar(title: name, leadingText: 'Cancel'),
          bottomNavigationBar: widget.role == 'admin'
              ? _buildAdminBottomBar(currentMachineData)
              : null,
          body:
              FutureBuilder<
                QueryResult<
                  GetRoutinesByMachineIdData,
                  GetRoutinesByMachineIdVariables
                >
              >(
                future: _routinesFuture,
                builder: (context, routineSnapshot) {
                  // Initialize the checklist only once after data is fetched.
                  if (routineSnapshot.connectionState == ConnectionState.done &&
                      routineSnapshot.hasData) {
                    _initRoutinesFromSnapshot(
                      routineSnapshot.data!.data.routines,
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Large machine image header
                        Center(
                          child: Image.network(
                            imageUrl,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.image_not_supported,
                              size: 100,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                              // Conditional actions based on user role
                              if (widget.role == 'staff') ...[
                                const SizedBox(height: 30),
                                _buildActionButtons(context, name: name),
                              ],

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
              ),
        );
      },
    );
  }

  /// Builds the sticky bottom bar for Admin users containing Update and Delete actions.
  Widget _buildAdminBottomBar(Map<String, dynamic> currentMachineData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateMachinePage(
                        machineData: currentMachineData.cast<String, dynamic>(),
                      ),
                    ),
                  );
                  if (result == true && mounted) {
                    _loadMachine();
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Update'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _confirmDeleteMachine(context),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the QR Code generator button.
  Widget _buildMachineQRCode(BuildContext context, {String? machineID}) {
    return SizedBox(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.qr_code),
        label: const Text("QR Code", style: TextStyle(color: Colors.black)),
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

  /// Builds primary action buttons (like Submit Request) based on roles.
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
        ],
      );
    }
    return const SizedBox.shrink();
  }

  /// Builds the section for routine maintenance checklists.
  Widget _buildRoutineChecklistSection(
    BuildContext context,
    AsyncSnapshot snapshot,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Routine Checklist',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        if (widget.role == 'admin') ...[
          _buildActionButtons(context, name: widget.machineData['name']),
          const SizedBox(height: 16),
        ],
        _buildRoutineContent(snapshot),
      ],
    );
  }

  /// Handles the conditional rendering of the routine list (loading/empty/content).
  Widget _buildRoutineContent(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting &&
        _checklistItems.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_checklistItems.isEmpty) {
      return const Center(
        child: Text(
          'No routine checklist items found.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return _buildRoutineList();
  }

  /// Renders the scrollable list of routine checklist items.
  Widget _buildRoutineList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._checklistItems.map((item) {
          return _RoutineTile(
            item: item,
            role: widget.role,
            onChanged: (bool? val) {
              setState(() {
                item['isDone'] = val ?? false;
              });
            },
            onDelete: () => _confirmDeleteRoutine(context, item),
          );
        }).toList(),
        const SizedBox(height: 20),
        if (_checklistItems.isNotEmpty &&
            (widget.role == 'mechanic' || widget.role == 'admin'))
          Center(
            child: SizedBox(
              width: 150,
              height: 45,
              child: ElevatedButton(
                onPressed: _isSavingRoutines ? null : _saveRoutines,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSavingRoutines
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Save Progress'),
              ),
            ),
          ),
      ],
    );
  }

  /// Displays a confirmation dialog before deleting a specific routine item.
  Future<void> _confirmDeleteRoutine(
    BuildContext context,
    Map<String, dynamic> item,
  ) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Routine'),
        content: Text('Are you sure you want to delete "${item['title']}"?'),
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

    if (confirm == true && context.mounted) {
      // Optimistic update for instant UI feedback
      setState(() {
        _checklistItems.removeWhere((element) => element['id'] == item['id']);
      });
      try {
        await ConnectorConnector.instance
            .deleteRoutine(id: item['id'])
            .execute();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Routine deleted successfully')),
          );
          _loadRoutines(); // Reload to sync with server
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
          );
          _loadRoutines(); // Reload to restore item if deletion failed
        }
      }
    }
  }
}

/// A private tile widget for individual routine maintenance checklist items.
class _RoutineTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final String role;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;

  const _RoutineTile({
    required this.item,
    required this.role,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onChanged(!(item['isDone'] as bool)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (item['subtitle']?.isNotEmpty == true) ...[
                        const SizedBox(height: 4),
                        Text(
                          item['subtitle'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (role == 'admin')
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: onDelete,
                  ),
                Checkbox(
                  value: item['isDone'],
                  onChanged: onChanged,
                  activeColor: Colors.deepOrange,
                  checkColor: Colors.white,
                  side: const BorderSide(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
