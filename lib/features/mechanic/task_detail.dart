import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';
import '../../../shared/services/request_service.dart';

class TaskDetailPage extends StatefulWidget {
  final String requestId;
  final String machineId;
  final String machineName;
  final String description;

  const TaskDetailPage({
    super.key,
    required this.requestId,
    required this.machineId,
    required this.machineName,
    required this.description,
  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  // Local copy of routine states so user can toggle checkboxes before saving
  List<Map<String, dynamic>> _routineItems = [];
  bool _routinesInitialized = false;

  late final Future<
    QueryResult<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>
  >
  _routinesFuture;

  @override
  void initState() {
    super.initState();
    _routinesFuture = ConnectorConnector.instance
        .getRoutinesByMachineId(machineId: widget.machineId)
        .execute();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<
      QueryResult<GetRoutinesByMachineIdData, GetRoutinesByMachineIdVariables>
    >(
      future: _routinesFuture,
      builder: (context, snapshot) {
        // Populate local state once on first successful load
        if (snapshot.hasData && !_routinesInitialized) {
          _routinesInitialized = true;
          _routineItems = (snapshot.data!.data.routines)
              .map(
                (r) => {
                  'id': r.id,
                  'title': r.title ?? 'No Title',
                  'description': r.description ?? '',
                  'isDone': r.isCheck ?? false,
                },
              )
              .toList();
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              widget.machineName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            leadingWidth: 80,
            leading: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            actions: [
              TextButton(
                onPressed: snapshot.connectionState == ConnectionState.waiting
                    ? null
                    : () async {
                        try {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saving task...')),
                          );

                          // Save all routine checkbox states
                          for (final item in _routineItems) {
                            await ConnectorConnector.instance
                                .updateRoutine(
                                  id: item['id'],
                                  isCheck: item['isDone'],
                                )
                                .execute();
                          }

                          // Mark request as Fixed + auto-creates MaintainLog
                          await RequestService().completeRequest(
                            requestId: widget.requestId,
                            machineId: widget.machineId,
                            machineName: widget.machineName,
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Task saved successfully!'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error saving task: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Machine Description Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.description,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 2. Routine Checklist from Firebase
                      if (snapshot.connectionState == ConnectionState.waiting)
                        const Center(child: CircularProgressIndicator())
                      else if (snapshot.hasError)
                        Center(
                          child: Text(
                            'Error loading routines: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      else if (_routineItems.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              'No routine checklist for this machine.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      else
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black, width: 1.5),
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _routineItems.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              thickness: 1.5,
                              color: Colors.black,
                            ),
                            itemBuilder: (context, index) {
                              final item = _routineItems[index];
                              return CheckboxListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                title: Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle:
                                    (item['description'] as String).isNotEmpty
                                    ? Text(
                                        item['description'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade700,
                                        ),
                                      )
                                    : null,
                                value: item['isDone'] as bool,
                                activeColor: Colors.deepOrange,
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _routineItems[index]['isDone'] =
                                        value ?? false;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
