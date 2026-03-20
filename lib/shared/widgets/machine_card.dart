/// UI component for displaying machine information in a card format.
///
/// This card includes an image, name, description, and optional trailing widget.
/// It's used primarily in the [MachineListPage].
///
/// @author Jinnawat Janngam
import 'package:flutter/material.dart';

/// A reusable card widget for machine data.
class MachineCard extends StatelessWidget {
  /// The URL of the machine's image.
  final String imageUrl;
  
  /// The name of the machine.
  final String name;
  
  /// A brief description of the machine.
  final String description;
  
  /// Callback triggered when the card is tapped.
  final VoidCallback? onTap;
  
  /// An optional widget to display at the end of the title row.
  final Widget? trailing;

  /// Creates a [MachineCard].
  const MachineCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Machine Image Section
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            
            // Machine Information Section
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
                          name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (trailing != null) trailing!,
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
