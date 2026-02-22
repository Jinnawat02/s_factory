import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:s_factory/dataconnect_generated/generated.dart';
import 'package:s_factory/shared/functions/convert_time.dart';

class DataView extends StatelessWidget {
  const DataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Connect Requests')),
      body: FutureBuilder<QueryResult<ListRequestsData, void>>(
        future: ConnectorConnector.instance.listRequests().execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.data.requests.isEmpty) {
            return const Center(child: Text('No requests found'));
          }
          final requests = snapshot.data!.data.requests;
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return ListTile(
                title: Text(request.description ?? 'No Description'),
                subtitle: Text(
                  'Status: ${request.status} \nUser: ${request.user.email}',
                ),
                isThreeLine: true,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createRequest(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _createRequest(BuildContext context) async {
    try {
      // NOTE: In a real app, you would get these values from the UI/Auth
      Timestamp gqlTimestamp = isoToGql(
        DateTime.now().toUtc().toIso8601String(),
      );
      // 1. Ensure User exists
      await ConnectorConnector.instance
          .upsertUser(email: "admin@example.com")
          .execute();

      // 2. Ensure Machine exists
      await ConnectorConnector.instance
          .upsertMachine(id: "11111111-1111-4111-8111-111111111111")
          .execute();

      // 3. Create Request
      await ConnectorConnector.instance
          .createRequest(
            userEmail: "admin@example.com",
            machineId: "11111111-1111-4111-8111-111111111111",
            description: "New Request from Flutter App ${DateTime.now()}",
            requestDate: gqlTimestamp,
          )
          .execute();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request created successfully! Reload to see.'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error creating request: $e')));
      }
    }
  }
}
