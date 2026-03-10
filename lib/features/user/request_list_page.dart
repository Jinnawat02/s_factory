import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';

import '../../mock/machine_mock_data.dart';
import 'request_detail.dart';

class RequestListPage extends StatelessWidget {
  const RequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FutureBuilder<QueryResult<ListRequestsData, void>>(
        future: ConnectorConnector.instance.listRequests().execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading requests: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final allRequests = snapshot.data?.data.requests ?? [];

          // Sort requests by newest first
          final sortedRequests = List<ListRequestsRequests>.from(allRequests)
            ..sort(
              (a, b) => b.requestDate.toDateTime().compareTo(
                a.requestDate.toDateTime(),
              ),
            );

          if (sortedRequests.isEmpty) {
            return const Center(
              child: Text(
                'No requests found.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.separated(
            itemCount: sortedRequests.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final request = sortedRequests[index];

              // Try to find the machine's image from mock data (fallback since imageUrl not in Connect yet)
              final machineId = request.machine.id;
              final machineMap = MachineMockData.machines.firstWhere(
                (m) => m['id'] == machineId,
                orElse: () => {
                  'imageUrl': 'https://picsum.photos/200?random=$machineId',
                },
              );
              final imageUrl = machineMap['imageUrl'];

              // Format the displayed title
              final machineName = request.machine.name ?? 'Unknown Machine';
              final title = 'Request $machineName';

              // Format the displayed date
              final dateText = DateFormat(
                'dd/MM/yyyy HH:mm',
              ).format(request.requestDate.toDateTime().toLocal());

              return Container(
                color: Colors.white,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl)
                        : null,
                    child: imageUrl == null
                        ? const Icon(Icons.image_outlined, color: Colors.grey)
                        : null,
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    request.description ?? 'No description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    dateText,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RequestDetailPage(requestId: request.id),
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
