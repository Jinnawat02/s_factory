import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';

import '../../mock/machine_mock_data.dart';
import '../../shared/widgets/machine_card.dart';
import 'add_machine_page.dart';
import 'machine_detail_page.dart';

class MachineListPage extends StatelessWidget {
  final String role; // Require the user's role

  const MachineListPage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMachinePage()),
          );
        },
        tooltip: 'Add Machine',
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;
          if (constraints.maxWidth > 840) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth > 420) {
            crossAxisCount = 2;
          }

          return FutureBuilder<QueryResult<ListMachinesData, void>>(
            future: ConnectorConnector.instance.listMachines().execute(),
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

                  // DataConnect Schema hasn't added imageUrl yet, so we use a mock one
                  // based on the index or falling back to picsum.
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
                        // We pass the raw map structure to MachineDetailPage
                        // to keep compatibility without rewriting the detail page entirely yet
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
                          role: role,
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
