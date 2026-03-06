import 'package:flutter/material.dart';
import '../../../dataconnect_generated/generated.dart';

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
  // Mock data for parts list based on the wireframe
  final List<Map<String, dynamic>> _mockParts = [
    {
      'label': 'This is your label',
      'description': 'This is your description',
      'quantity': 1,
    },
    {
      'label': 'This is your label',
      'description': 'This is your description',
      'quantity': 1,
    },
    {
      'label': 'This is your label',
      'description': 'This is your description',
      'quantity': 1,
    },
    {
      'label': 'This is your label',
      'description': 'This is your description',
      'quantity': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Match clean wireframe look
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
            onPressed: () async {
              try {
                // Show saving indicator
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Saving task...')));

                // Update request status to 'Fixed'
                await ConnectorConnector.instance
                    .updateRequestStatus(id: widget.requestId, status: 'Fixed')
                    .execute();

                // Create a MaintainLog showing task is completed
                await ConnectorConnector.instance
                    .createMaintainLog(
                      title: 'Fixed Request: ${widget.machineName}',
                      isDone: true,
                      machineId: widget.machineId,
                    )
                    .execute();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task saved successfully!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context); // Go back to the list
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Machine Description/Detail Box
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

                  // 2. Search Bar
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Icon(Icons.search, color: Colors.black87),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            // Clear search logic
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 3. Parts List
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 1.5),
                        bottom: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _mockParts.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      itemBuilder: (context, index) {
                        final part = _mockParts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              // Left side: Label and Description
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      part['label'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      part['description'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Right side: - 1 + and Delete Icon
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (part['quantity'] > 1) {
                                        setState(() {
                                          part['quantity']--;
                                        });
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Icon(Icons.remove, size: 20),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${part['quantity']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        part['quantity']++;
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Icon(Icons.add, size: 20),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _mockParts.removeAt(index);
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
  }
}
