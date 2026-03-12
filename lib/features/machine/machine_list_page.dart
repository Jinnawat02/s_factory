import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../dataconnect_generated/generated.dart';

import '../../shared/widgets/machine_card.dart';
import 'add_machine_page.dart';
import 'machine_detail_page.dart';

class MachineListPage extends StatefulWidget {
  final String role;

  const MachineListPage({super.key, required this.role});

  @override
  State<MachineListPage> createState() => _MachineListPageState();
}

class _MachineListPageState extends State<MachineListPage> {
  late Future<QueryResult<ListMachinesData, void>> _futureMachines;

  @override
  void initState() {
    super.initState();
    _loadMachines();
  }

  void _loadMachines() {
    setState(() {
      _futureMachines = ConnectorConnector.instance.listMachines().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<QueryResult<ListMachinesData, void>>(
        future: _futureMachines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final allMachines = snapshot.data?.data.machines ?? [];

          final bool isAdmin = widget.role == 'admin';

          return Column(
            children: [
              if (isAdmin)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                  child: _buildAddMachineButton(context),
                ),
              if (allMachines.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No machines found.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                )
              else
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      if (constraints.maxWidth > 840) {
                        crossAxisCount = 3;
                      } else if (constraints.maxWidth > 420) {
                        crossAxisCount = 2;
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 320,
                        ),
                        itemCount: allMachines.length,
                        itemBuilder: (context, index) {
                          final machine = allMachines[index];

                          final machineImage =
                              machine.imageUrl ??
                              'https://ui-avatars.com/api/?name=${Uri.encodeComponent(machine.name!)}&background=0D47A1&color=fff&size=200&bold=true';

                          return MachineCard(
                            name: machine.name ?? 'Unknown Machine',
                            description:
                                machine.description ??
                                'No description available',
                            imageUrl: machineImage,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MachineDetailPage(
                                    machineData: {
                                      'id': machine.id,
                                      'name': machine.name ?? 'Unknown Machine',
                                      'serialNumber':
                                          machine.serialNumber?.toString() ??
                                          'N/A',
                                      'description':
                                          machine.description ??
                                          'No description available',
                                      'imageUrl': machineImage,
                                    },
                                    role: widget.role,
                                  ),
                                ),
                              );
                              if (context.mounted) {
                                _loadMachines();
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddMachineButton(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: () async {
          final created = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (context) => const AddMachinePage()),
          );
          if (created == true && mounted) {
            _loadMachines();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white.withOpacity(0.1),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          width: double.infinity,
          height: 50,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(2.5),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add, color: Colors.black, size: 20),
                ),
              ),
              SizedBox(width: 2),
              Text(
                'Add Machine',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
