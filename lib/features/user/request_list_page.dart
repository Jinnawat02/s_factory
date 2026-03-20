/// Screen displaying all pending and historical maintenance requests for the user.
///
/// Periodically fetches the authenticated user's requests and presents them
/// in a scrollable, chronologically ordered list.
///
/// @author Thanat Phadinkaew
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';

import 'request_detail.dart';

/// A screen that retrieves and lists maintenance requests tied to the current user.
class RequestListPage extends StatefulWidget {
  /// Creates a [RequestListPage].
  const RequestListPage({super.key});

  @override
  State<RequestListPage> createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  late Future<QueryResult<ListRequestsData, ListRequestsVariables>> _requestsFuture;

  @override
  void initState() {
    super.initState();
    _reloadsRequests();
  }

  void _reloadsRequests() {
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email;
    if (currentUserEmail != null) {
      setState(() {
        _requestsFuture = ConnectorConnector.instance
            .listRequests(email: currentUserEmail)
            .execute();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    if (currentUserEmail == null) {
      return const Scaffold(body: Center(child: Text('User not logged in.')));
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: FutureBuilder<QueryResult<ListRequestsData, ListRequestsVariables>>(
        future: _requestsFuture,
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
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.grey),
            itemBuilder: (context, index) {
              final request = sortedRequests[index];

              final machineName = request.machine.name ?? 'Unknown Machine';

              // Use machine's imageUrl or fallback to UI avatar
              final imageUrl =
                  request.machine.imageUrl ??
                  'https://ui-avatars.com/api/?name=${Uri.encodeComponent(machineName)}&background=0D47A1&color=fff&size=200&bold=true';

              // Format the displayed title
              final title = 'Request $machineName';

              // Format the displayed date
              final dateText = DateFormat(
                'dd/MM/yyyy HH:mm',
              ).format(request.requestDate.toDateTime().toLocal());

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
                    request.description ?? 'No description',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Text(
                    dateText,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RequestDetailPage(requestId: request.id),
                      ),
                    );
                    _reloadsRequests();
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
