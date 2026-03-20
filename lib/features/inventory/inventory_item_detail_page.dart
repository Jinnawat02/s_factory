/// Inventory item detail page for the s_factory application.
///
/// @author Siwakorn Soemchatchroenkan
import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';
import '../../shared/widgets/nav_bar.dart';
import 'update_inventory_item_page.dart';
import '../../shared/utils/snackbar_utils.dart';

/// A detail page for a single inventory item.
///
/// Fetches live item data from Firebase Data Connect using [itemData]'s `id`
/// field and displays name, description, stock count, location, and category.
///
/// Admin users see an **Update** and a **Delete** button in the bottom bar.
///
/// Example usage:
/// ```dart
/// InventoryItemDetailPage(
///   itemData: {'id': '123', 'name': 'Bearing'},
///   role: 'admin',
/// )
/// ```
class InventoryItemDetailPage extends StatefulWidget {
  /// A map containing at minimum the `id` and `name` of the item.
  /// Additional fields (`description`, `stock`, `imageUrl`, etc.) are used
  /// as fallback values while the network request is in-flight.
  final Map<String, dynamic> itemData;

  /// The role of the currently logged-in user.
  /// Pass `'admin'` to show the Update/Delete bottom bar.
  final String? role;

  /// Creates an [InventoryItemDetailPage].
  const InventoryItemDetailPage({super.key, required this.itemData, this.role});

  @override
  State<InventoryItemDetailPage> createState() =>
      _InventoryItemDetailPageState();
}

class _InventoryItemDetailPageState extends State<InventoryItemDetailPage> {
  Future<QueryResult<GetItemData, GetItemVariables>>? _itemFuture;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  /// Fetches the latest item data from Firebase Data Connect.
  ///
  /// If [itemData]`['id']` is `null` the future is set to `null` and the page
  /// renders using the values already present in [itemData].
  void _loadItem() {
    setState(() {
      _itemFuture = widget.itemData['id'] == null
          ? null
          : ConnectorConnector.instance
                .getItem(id: widget.itemData['id']!)
                .execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QueryResult<GetItemData, GetItemVariables>>(
      future: _itemFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: NavBar(title: widget.itemData['name'], leadingText: 'Back'),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: NavBar(title: widget.itemData['name'], leadingText: 'Back'),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final item = snapshot.data?.data.item;
        final name = item?.name ?? widget.itemData['name'] ?? 'Unknown Item';
        final description =
            item?.description ??
            widget.itemData['description'] ??
            'No description available.';
        final stock = item?.quantity ?? widget.itemData['stock'] ?? 0;
        final imageUrl = item?.imageUrl ?? widget.itemData['imageUrl'];

        final currentItemData = {
          ...widget.itemData,
          'name': name,
          'description': description,
          'stock': stock,
          if (imageUrl != null) 'imageUrl': imageUrl,
        };

        return Scaffold(
          appBar: NavBar(title: name, leadingText: 'Back'),
          bottomNavigationBar: widget.role == 'admin'
              ? _buildAdminBottomBar(currentItemData)
              : null,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null)
                  Image.network(
                    imageUrl,
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
                        description,
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
                            _buildInfoRow('Stock Available', '$stock units'),
                            const Divider(height: 24),
                            _buildInfoRow(
                              'Location',
                              currentItemData['location'] ?? 'N/A',
                            ),
                            const Divider(height: 24),
                            _buildInfoRow(
                              'Category',
                              currentItemData['category'] ?? 'N/A',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Returns a bottom action bar with **Update** and **Delete** buttons.
  ///
  /// Only rendered when [role] is `'admin'`.
  /// Tapping **Update** navigates to [UpdateInventoryItemPage];
  /// tapping **Delete** opens a confirmation dialog via [_confirmDeleteItem].
  Widget _buildAdminBottomBar(Map<String, dynamic> currentItemData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
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
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateInventoryItemPage(itemData: currentItemData),
                    ),
                  );
                  if (result == true && mounted) {
                    _loadItem();
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Update'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _confirmDeleteItem(context, currentItemData),
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

  /// Builds a grey placeholder box shown when the item has no image.
  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.grey[300],
      child: const Icon(Icons.inventory_2, size: 100, color: Colors.grey),
    );
  }

  /// Builds a single key-value row used inside the info panel.
  ///
  /// [label] is displayed in light grey on the left; [value] is bold-white on the right.
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

  /// Shows a confirmation dialog before permanently deleting the item.
  ///
  /// On confirmation, calls `ConnectorConnector.deleteItem` and pops the route
  /// with `true` so the parent list can refresh.
  Future<void> _confirmDeleteItem(
    BuildContext context,
    Map<String, dynamic> itemData,
  ) async {
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

    if (confirm == true && mounted) {
      try {
        await ConnectorConnector.instance
            .deleteItem(id: itemData['id'])
            .execute();
        if (mounted) {
          SnackBarUtils.showSuccess(context, 'Item deleted successfully');
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          SnackBarUtils.showError(context, 'Error deleting item: $e');
        }
      }
    }
  }
}
