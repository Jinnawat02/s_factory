import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';
import '../../../shared/services/request_service.dart';
import '../../../shared/widgets/nav_bar.dart';
import '../../shared/utils/snackbar_utils.dart';

class TaskDetailPage extends StatefulWidget {
  final String requestId;
  final String machineId;
  final String machineName;
  final String description;
  final String? imageUrl;

  const TaskDetailPage({
    super.key,
    required this.requestId,
    required this.machineId,
    required this.machineName,
    required this.description,
    this.imageUrl,
  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  bool _isLoading = true;
  bool _isSavingMain = false;
  bool _isSavingParts = false;

  List<ListItemsItems> _allItems = [];
  List<Map<String, dynamic>> _selectedParts = [];
  List<String> _initialSavedPartIds = [];

  Key _autocompleteKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final itemsFuture = ConnectorConnector.instance.listItems().execute();

      final taskItemsFuture = ConnectorConnector.instance
          .getTaskItemsByRequestId(requestId: widget.requestId)
          .execute();

      final results = await Future.wait([itemsFuture, taskItemsFuture]);

      final itemsResult = results[0] as QueryResult<ListItemsData, void>;
      final taskItemsResult = results[1] as QueryResult<
        GetTaskItemsByRequestIdData,
        GetTaskItemsByRequestIdVariables
      >;

      if (!mounted) return;

      setState(() {
        _allItems = itemsResult.data.items;

        _selectedParts = taskItemsResult.data.taskItems.map((ti) {
          // Find the original item to get description and inventory quantity
          final originalItem =
              _allItems.where((i) => i.id == ti.item.id).firstOrNull;
          return {
            'taskItemId': ti.id,
            'itemId': ti.item.id,
            'name': ti.item.name ?? 'Unknown Part',
            'description': originalItem?.description ?? '',
            'imageUrl': ti.item.imageUrl,
            'quantity': ti.quantity,
            'inventoryQuantity': originalItem?.quantity ?? 0,
            'isSaved': true,
          };
        }).toList();

        _initialSavedPartIds =
            _selectedParts.map((p) => p['taskItemId'] as String).toList();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      SnackBarUtils.showError(context, 'Error loading data: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveParts() async {
    setState(() => _isSavingParts = true);
    try {
      final currentSavedIds = _selectedParts
          .where((p) => p['isSaved'] == true)
          .map((p) => p['taskItemId'] as String)
          .toList();

      final deletedIds = _initialSavedPartIds
          .where((id) => !currentSavedIds.contains(id))
          .toList();

      for (String id in deletedIds) {
        await ConnectorConnector.instance.deleteTaskItem(id: id).execute();
      }

      final newParts =
          _selectedParts.where((p) => p['isSaved'] == false).toList();
      for (var part in newParts) {
        if ((part['taskItemId'] as String).isNotEmpty) {
          await ConnectorConnector.instance
              .deleteTaskItem(id: part['taskItemId'])
              .execute();
        }

        await ConnectorConnector.instance
            .createTaskItem(
              requestId: widget.requestId,
              itemId: part['itemId'],
              quantity: part['quantity'],
            )
            .execute();
      }

      await _fetchData();
      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Parts saved successfully');
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'Error saving parts: $e');
      }
    } finally {
      if (mounted) setState(() => _isSavingParts = false);
    }
  }

  Future<void> _saveMainTask() async {
    setState(() => _isSavingMain = true);
    try {
      // Deduct stock for all saved parts
      final savedParts =
          _selectedParts.where((p) => p['isSaved'] == true).toList();
      for (var part in savedParts) {
        final currentStock = part['inventoryQuantity'] as int;
        final usedStock = part['quantity'] as int;
        final newStock = currentStock - usedStock;
        if (newStock >= 0) {
          await ConnectorConnector.instance
              .updateItem(id: part['itemId'])
              .quantity(newStock)
              .execute();
        }
      }

      await RequestService().completeRequest(
        requestId: widget.requestId,
        machineId: widget.machineId,
        machineName: widget.machineName,
      );

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Task saved successfully!');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'Error saving task: $e');
      }
    } finally {
      if (mounted) setState(() => _isSavingMain = false);
    }
  }

  void _addPart(ListItemsItems item) {
    if (_selectedParts.any((p) => p['itemId'] == item.id)) {
      SnackBarUtils.showError(context, 'Part already added');
      return;
    }

    if ((item.quantity ?? 0) < 1) {
      SnackBarUtils.showError(context, 'Item out of stock');
      return;
    }

    setState(() {
      _selectedParts.add({
        'taskItemId': '', // Not saved yet
        'itemId': item.id,
        'name': item.name ?? 'Unknown',
        'description': item.description ?? '',
        'imageUrl': item.imageUrl,
        'quantity': 1,
        'inventoryQuantity': item.quantity ?? 0,
        'isSaved': false,
      });
    });
  }

  Widget _buildMachineImage() {
    final imageUrl = widget.imageUrl;
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            )
          : const Center(
              child: Icon(Icons.settings, size: 50, color: Colors.grey),
            ),
    );
  }

  Widget _buildMachineDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.machineName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMachineParts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Machine Parts',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            TextButton.icon(
              onPressed: _isSavingParts ? null : _saveParts,
              icon: _isSavingParts
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.deepOrange,
                      ),
                    )
                  : const Icon(Icons.save, color: Colors.deepOrange),
              label: Text(
                'Save Parts',
                style: TextStyle(
                  color: _isSavingParts ? Colors.grey : Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Search AutoComplete
        Autocomplete<ListItemsItems>(
          key: _autocompleteKey,
          displayStringForOption: (option) => '',
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return _allItems;
            }
            return _allItems.where(
              (item) => (item.name ?? '')
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()),
            );
          },
          onSelected: (option) {
            _addPart(option);
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              _autocompleteKey = UniqueKey();
            });
          },
          fieldViewBuilder:
              (context, controller, focusNode, onEditingComplete) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search parts...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    controller.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      _autocompleteKey = UniqueKey();
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: Colors.grey[800],
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: options.isEmpty
                      ? 0
                      : (options.length < 4 ? options.length * 60.0 : 250),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);
                      return ListTile(
                        title: Text(
                          option.name ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Stock: ${option.quantity ?? 0}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        onTap: () => onSelected(option),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        ..._selectedParts.map((part) {
          final maxStock = part['inventoryQuantity'] as int;

          return Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade800)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: part['imageUrl'] != null
                      ? Image.network(
                          part['imageUrl'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[800],
                          child: const Icon(Icons.build, color: Colors.grey),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        part['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        part['description'],
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () {
                              setState(() {
                                if (part['quantity'] > 1) {
                                  part['quantity']--;
                                  part['isSaved'] = false;
                                }
                              });
                            },
                          ),
                          Text(
                            '${part['quantity']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.deepOrange,
                            ),
                            onPressed: () {
                              setState(() {
                                if (part['quantity'] < maxStock) {
                                  part['quantity']++;
                                  part['isSaved'] = false;
                                } else {
                                  SnackBarUtils.showError(
                                    context,
                                    'Only $maxStock in stock',
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _selectedParts.remove(part);
                    });
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const NavBar(title: 'Task Details', leadingText: 'Back'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMachineImage(),
                  const SizedBox(height: 20),
                  _buildMachineDetails(),
                  const SizedBox(height: 30),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 20),
                  _buildMachineParts(),
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isSavingMain ? null : _saveMainTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isSavingMain
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Complete & Save',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
