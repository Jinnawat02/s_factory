import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../dataconnect_generated/generated.dart';

import '../../mock/machine_mock_data.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (context) => const AddMachinePage()),
          );
          if (created == true) {
            _loadMachines();
          }
        },
        tooltip: 'Add Machine',
        child: const Icon(Icons.add),
      ),
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

          if (allMachines.isEmpty) {
            return const Center(child: Text('No machines found.'));
          }

          return LayoutBuilder(
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

                  final mockImage = index < MachineMockData.machines.length
                      ? MachineMockData.machines[index]['imageUrl']
                      : 'https://picsum.photos/400/300?random=${machine.id}';

                  return MachineCard(
                    name: machine.name ?? 'Unknown Machine',
                    description:
                        machine.description ?? 'No description available',
                    imageUrl: mockImage!,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MachineDetailPage(
                          machineData: {
                            'id': machine.id,
                            'name': machine.name ?? 'Unknown Machine',
                            'serialNumber':
                                machine.serialNumber?.toString() ?? 'N/A',
                            'description':
                                machine.description ??
                                'No description available',
                            'imageUrl': mockImage,
                          },
                          role: widget.role,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
