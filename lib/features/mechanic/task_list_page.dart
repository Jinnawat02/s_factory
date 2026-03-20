/// Screen displaying a list of tasks assigned to the current mechanic.
///
/// Fetches the authenticated user's email and retrieves their assigned
/// task requests from the backend. Sorts them chronologically and routes
/// to the detailed task view.
///
/// @author Thanat Phadinkaew
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';

import 'task_detail.dart';

/// A screen that retrieves and lists all pending and completed maintenance tasks.
class TaskListPage extends StatefulWidget {
  /// Creates a [TaskListPage].
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
      backgroundColor: Colors.grey[900],
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
                    const Divider(height: 1, color: Colors.grey),
                itemBuilder: (context, index) {
                  final task = sortedTasks[index];

                  final machineName = task.machine.name ?? 'Unknown Machine';

                  // Use machine's imageUrl or fallback to UI avatar
                  final imageUrl =
                      task.machine.imageUrl ??
                      'https://ui-avatars.com/api/?name=${Uri.encodeComponent(machineName)}&background=0D47A1&color=fff&size=200&bold=true';

                  // Format labels
                  final title = 'Request $machineName';
                  final dateText = DateFormat(
                    'dd/MM/yyyy HH:mm',
                  ).format(task.requestDate.toDateTime().toLocal());

                  return Container(
                    color: Colors.grey[850],
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[800],
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        task.description ?? 'No description provided.',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (task.status?.toLowerCase() == 'pending')
                                Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      width: 1.5,
                                    ),
                                  ),
                                )
                              else if (task.status?.toLowerCase() == 'fixed')
                                Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                              Text(
                                dateText,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailPage(
                              requestId: task.id,
                              machineId: task.machine.id,
                              machineName: machineName,
                              description: task.description ?? 'N/A',
                              imageUrl: imageUrl,
                            ),
                          ),
                        );
                        // Refresh the list after returning from the detail page
                        if (mounted) {
                          setState(() {});
                        }
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
