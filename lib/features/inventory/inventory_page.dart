import 'package:flutter/material.dart';

import 'inventory_item_detail_page.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
            mainAxisExtent: 320,
          ),
          itemCount: 10, // Placeholder count
          itemBuilder: (context, index) {
            final itemName = 'Inventory Item ${index + 1}';
            final stockCount = (index + 1) * 5 + 10;
            final location = 'Rack A-${index + 1}';

            return Card(
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  final itemData = {
                    'name': itemName,
                    'stock': stockCount.toString(),
                    'location': location,
                    'category': 'Spare Parts',
                    'description':
                        'This is a placeholder description for $itemName. High-quality component for factory machinery maintenance and repair.',
                  };

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InventoryItemDetailPage(itemData: itemData),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.inventory_2,
                          size: 64,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  itemName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Location: Rack A-${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.deepOrange[300],
                              fontWeight: FontWeight.w500,
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
      },
    );
  }
}
