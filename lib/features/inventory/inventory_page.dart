/// Inventory list page for the s_factory application.
///
/// @author Siwakorn Soemchatchroenkan — Individual feature on inventory function
import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../dataconnect_generated/generated.dart';

import 'inventory_item_detail_page.dart';
import 'add_inventory_item_page.dart';

/// A page that displays the full list of inventory items.
///
/// Shows a responsive grid of [InventoryItemDetailPage] cards.
/// Admins see an **Add Item** button at the top to navigate to
/// [AddInventoryItemPage].
///
/// Example usage:
/// ```dart
/// InventoryPage(role: 'admin')
/// ```
class InventoryPage extends StatefulWidget {
  /// The role of the currently logged-in user (e.g. `'admin'`, `'staff'`).
  /// Controls whether the Add-Item button is visible.
  final String? role;

  /// Creates an [InventoryPage].
  ///
  /// [role] is optional; when omitted the page renders in read-only mode.
  const InventoryPage({super.key, this.role});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late Future<QueryResult<ListItemsData, void>> _futureItems;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  /// Triggers a fresh fetch of all inventory items from Firebase Data Connect
  /// and rebuilds the widget tree once the [Future] resolves.
  void _loadItems() {
    setState(() {
      _futureItems = ConnectorConnector.instance.listItems().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<QueryResult<ListItemsData, void>>(
        future: _futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data?.data.items ?? [];
          final bool isAdmin = widget.role == 'admin';

          return Column(
            children: [
              if (isAdmin)
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                  child: _buildAddInventoryItemButton(context),
                ),
              if (items.isEmpty)
                const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No inventory items found',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      if (constraints.maxWidth > 840) {
                        crossAxisCount = 3;
                      } else if (constraints.maxWidth > 420) {
                        crossAxisCount = 2;
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent:
                              340, // increased to accommodate the image and text below
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final itemName = item.name ?? 'Unnamed Item';
                          final stockCount = item.quantity ?? 0;
                          final description =
                              item.description ?? 'No description available.';
                          final itemImage =
                              item.imageUrl ??
                              'https://ui-avatars.com/api/?name=${Uri.encodeComponent(itemName)}&background=0D47A1&color=fff&size=200&bold=true';

                          return Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        InventoryItemDetailPage(
                                          itemData: {
                                            'id': item.id,
                                            'name': itemName,
                                            'stock': stockCount.toString(),
                                            'location': 'N/A',
                                            'category': 'N/A',
                                            'description': description,
                                            'imageUrl': itemImage,
                                          },
                                          role: widget.role ?? '',
                                        ),
                                  ),
                                );
                                if (context.mounted) {
                                  _loadItems();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.network(
                                      itemImage,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                color: Colors.grey[200],
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                  size: 50,
                                                ),
                                              ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                itemName,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 14,
                                              color: Colors.grey[400],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Stock Available: $stockCount units',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          description,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
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
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  /// Builds the **Add Item** floating action button shown only to admins.
  ///
  /// Navigates to [AddInventoryItemPage] and reloads the list when an item
  /// is successfully created.
  Widget _buildAddInventoryItemButton(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: () async {
          final created = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddInventoryItemPage(),
            ),
          );
          if (created == true && mounted) {
            _loadItems();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white.withOpacity(0.1),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          width: double.infinity,
          height: 50,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(2.5),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add, color: Colors.black, size: 20),
                ),
              ),
              SizedBox(width: 2),
              Text(
                'Add Item',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
