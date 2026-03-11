import 'package:flutter/material.dart';

import '../../../dataconnect_generated/generated.dart';

import '../../shared/widgets/nav_bar.dart';
import '../../shared/utils/snackbar_utils.dart';

class InventoryItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> itemData;
  final String? role;

  const InventoryItemDetailPage({super.key, required this.itemData, this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: itemData['name'], leadingText: 'Back'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (itemData['imageUrl'] != null)
              Image.network(
                itemData['imageUrl'],
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.inventory_2,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Item Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    itemData['description'] ?? 'No description available.',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                        0.1,
                      ), // Adjusted for dark background
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          'Stock Available',
                          '${itemData['stock']} units',
                        ),
                        const Divider(height: 24),
                        _buildInfoRow('Location', itemData['location']),
                        const Divider(height: 24),
                        _buildInfoRow('Category', itemData['category']),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          SnackBarUtils.showSuccess(
                            context,
                            'Update Stock clicked (Placeholder)',
                          );
                        },
                        icon: const Icon(Icons.edit_document),
                        label: const Text(
                          'Update Stock',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (role == 'admin' && itemData['id'] != null) ...[
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () => _confirmDeleteItem(context),
                          icon: const Icon(Icons.delete),
                          label: const Text(
                            'Delete Item',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteItem(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete ${itemData['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      try {
        await ConnectorConnector.instance
            .deleteItem(id: itemData['id'])
            .execute();
        if (context.mounted) {
          SnackBarUtils.showSuccess(context, 'Item deleted successfully');
          Navigator.pop(
            context,
            true,
          ); // Pop the detail page, optionally returning true to refresh
        }
      } catch (e) {
        if (context.mounted) {
          SnackBarUtils.showError(context, 'Error deleting item: $e');
        }
      }
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70, // Matched for dark background
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
