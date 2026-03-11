import 'package:flutter/material.dart';
import '../../../dataconnect_generated/generated.dart';
import '../../shared/widgets/nav_bar.dart';
import 'update_inventory_item_page.dart';

class InventoryItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> itemData;
  final String? role;

  const InventoryItemDetailPage({super.key, required this.itemData, this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: itemData['name'], leadingText: 'Back'),
      // Matching the Machine Detail footbar pattern
      bottomNavigationBar: role == 'admin'
          ? _buildAdminBottomBar(context)
          : null,
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
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              )
            else
              _buildPlaceholder(),
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
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          'Stock Available',
                          '${itemData['stock']} units',
                        ),
                        const Divider(height: 24),
                        _buildInfoRow(
                          'Location',
                          itemData['location'] ?? 'N/A',
                        ),
                        const Divider(height: 24),
                        _buildInfoRow(
                          'Category',
                          itemData['category'] ?? 'N/A',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ), // Space so content isn't hidden by footbar
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated Footer Bar to match Machine Detail template exactly
  Widget _buildAdminBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900], // Match template color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Update Button - flex 1, blue background
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateInventoryItemPage(itemData: itemData),
                    ),
                  );
                  if (result == true && context.mounted) {
                    Navigator.pop(context, true); // Refresh list on return
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Update'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Delete Button - flex 1, red background
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _confirmDeleteItem(context),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.grey[300],
      child: const Icon(Icons.inventory_2, size: 100, color: Colors.grey),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item deleted successfully')),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }
}
