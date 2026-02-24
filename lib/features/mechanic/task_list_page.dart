import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';

import '../../mock/machine_mock_data.dart'; // Fallback for images if needed
import '../machine/machine_detail_page.dart'; // Navigate to detail

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  String? _mechanicEmail;
  bool _isLoadingEmail = true;

  @override
  void initState() {
    super.initState();
    _loadMechanicEmail();
  }

  Future<void> _loadMechanicEmail() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (mounted) {
      setState(() {
        _mechanicEmail = email;
        _isLoadingEmail = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingEmail) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_mechanicEmail == null) {
      return const Scaffold(
        body: Center(child: Text('Error: Could not determine mechanic email')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50], // Match modern clean theme
      body:
          FutureBuilder<
            QueryResult<
              GetRequestsByMechanicEmailData,
              GetRequestsByMechanicEmailVariables
            >
          >(
            future: ConnectorConnector.instance
                .getRequestsByMechanicEmail(email: _mechanicEmail!)
                .execute(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading tasks: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final allTasks = snapshot.data?.data.requests ?? [];

              // Sort requests by newest first
              final sortedTasks =
                  List<GetRequestsByMechanicEmailRequests>.from(allTasks)..sort(
                    (a, b) => b.requestDate.toDateTime().compareTo(
                      a.requestDate.toDateTime(),
                    ),
                  );

              if (sortedTasks.isEmpty) {
                return const Center(
                  child: Text(
                    'No assigned tasks found.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              return ListView.separated(
                padding:
                    EdgeInsets.zero, // Clean edge-to-edge look like wireframe
                itemCount: sortedTasks.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, thickness: 1, color: Colors.grey),
                itemBuilder: (context, index) {
                  final task = sortedTasks[index];

                  // Try to find the machine's image from mock data (fallback since imageUrl not in Connect yet)
                  final machineId = task.machine.id;
                  final machineMap = MachineMockData.machines.firstWhere(
                    (m) => m['id'] == machineId,
                    orElse: () => {
                      'imageUrl': 'https://picsum.photos/200?random=$machineId',
                      'description': 'N/A',
                    },
                  );
                  final imageUrl = machineMap['imageUrl'];
                  final mockDescription = machineMap['description'];

                  // Format labels
                  final machineName = task.machine.name ?? 'Unknown Machine';
                  final title = 'Request $machineName';

                  // Format date nicely like "14/10 14:30"
                  final dateText = DateFormat(
                    'dd/MM HH:mm',
                  ).format(task.requestDate.toDateTime().toLocal());

                  return Container(
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                            25,
                          ), // Fully rounded like wireframe
                          image: imageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: imageUrl == null
                            ? const Icon(
                                Icons.image_outlined,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        task.description ?? 'No description provided.',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: Text(
                        dateText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        // Provide empty map data matching machine_detail_page expectations, supplementing the id.
                        final navMachineData = {
                          'id': machineId,
                          'name': machineName,
                          'imageUrl':
                              imageUrl ??
                              'https://picsum.photos/200?random=$machineId',
                          'description': mockDescription ?? 'N/A',
                        };

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MachineDetailPage(
                              machineData: navMachineData,
                              role: 'mechanic', // Force mechanic view
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
    );
  }
}
