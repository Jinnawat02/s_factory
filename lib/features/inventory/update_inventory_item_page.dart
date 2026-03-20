/// Update inventory item page for the s_factory application.
///
/// @author Siwakorn Soemchatchroenkan — Individual feature on inventory function
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/widgets/nav_bar.dart';
import '../../dataconnect_generated/generated.dart';
import '../../shared/utils/storage_service.dart';

/// A form page that allows admins to edit an existing inventory item.
///
/// Pre-fills all fields with values from [itemData] so the admin only needs
/// to change what requires updating.
///
/// Supports editing:
/// - **Name** (required)
/// - **Quantity** — via increment / decrement stepper or direct input
/// - **Description**
/// - **Image** — replaces the existing image by uploading a new one to
///   Firebase Storage under `inventory/`
///
/// Returns `true` to the caller (via `Navigator.pop`) when the update
/// succeeds so [InventoryItemDetailPage] can reload the latest data.
///
/// Example usage:
/// ```dart
/// final result = await Navigator.push<bool>(
///   context,
///   MaterialPageRoute(
///     builder: (_) => UpdateInventoryItemPage(itemData: currentItemData),
///   ),
/// );
/// if (result == true) _loadItem();
/// ```
class UpdateInventoryItemPage extends StatefulWidget {
  /// A map containing the item's current values.
  ///
  /// Expected keys: `id`, `name`, `stock`, `description`, `imageUrl`.
  final Map<String, dynamic> itemData;

  /// Creates an [UpdateInventoryItemPage] pre-filled with [itemData].
  const UpdateInventoryItemPage({super.key, required this.itemData});

  @override
  State<UpdateInventoryItemPage> createState() =>
      _UpdateInventoryItemPageState();
}

class _UpdateInventoryItemPageState extends State<UpdateInventoryItemPage> {
  String? _existingImageUrl;

  @override
  void initState() {
    super.initState();
    _name = widget.itemData['name'] ?? '';
    _quantityStr = widget.itemData['stock']?.toString() ?? '0';
    _description = widget.itemData['description'] ?? '';
    _existingImageUrl = widget.itemData['imageUrl'];
    _stockController.text = _quantityStr;
  }

  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _quantityStr = '';
  String _description = '';
  bool _isLoading = false;
  XFile? _pickedImage;

  final TextEditingController _stockController = TextEditingController(
    text: '0',
  );

  @override
  void dispose() {
    _stockController.dispose();
    super.dispose();
  }

  /// Opens the device camera or photo gallery and stores the chosen file
  /// in [_pickedImage].
  ///
  /// [source] must be [ImageSource.gallery] or [ImageSource.camera].
  /// Images are compressed to 85 % quality before being stored locally.
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() => _pickedImage = image);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
      }
    }
  }

  /// Shows a bottom sheet so the user can choose between **Gallery** and
  /// **Camera** as the image source.
  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Validates the form, uploads a new image if one was picked, then calls
  /// `ConnectorConnector.updateItem` to persist all changes.
  ///
  /// Fields submitted:
  /// - [_name] — required item name
  /// - quantity — parsed from [_stockController] (defaults to `0`)
  /// - [_description] — optional free-text description
  /// - image URL — new upload if [_pickedImage] is set, otherwise
  ///   keeps [_existingImageUrl] unchanged
  ///
  /// Pops with `true` on success or shows a [SnackBar] error on failure.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final quantity = int.tryParse(_stockController.text) ?? 0;

    setState(() => _isLoading = true);

    try {
      String? uploadedImageUrl = _existingImageUrl;
      if (_pickedImage != null) {
        uploadedImageUrl = await StorageService.uploadImage(
          _pickedImage!,
          'inventory',
        );
      }

      await ConnectorConnector.instance
          .updateItem(id: widget.itemData['id']!)
          .name(_name)
          .quantity(quantity)
          .description(_description)
          .imageUrl(uploadedImageUrl)
          .execute();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item updated successfully')),
        );
        Navigator.pop(context, true); // true = item was created
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.4; // 40% of screen width

    return Scaffold(
      appBar: const NavBar(title: 'Add Inventory Item', leadingText: 'Cancel'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _showImageSourceSheet,
                  child: Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[600]!),
                    ),
                    child: _pickedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: kIsWeb
                                ? Image.network(
                                    _pickedImage!.path,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(_pickedImage!.path),
                                    fit: BoxFit.cover,
                                  ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Add Image',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'NAME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a name'
                    : null,
                onChanged: (value) => _name = value,
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'QUANTITY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          int current =
                              int.tryParse(_stockController.text) ?? 0;
                          if (current > 0) {
                            _stockController.text = (current - 1).toString();
                          }
                        },
                      ),
                      Container(
                        width: 48,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: TextFormField(
                          controller: _stockController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 15),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          int current =
                              int.tryParse(_stockController.text) ?? 0;
                          _stockController.text = (current + 1).toString();
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          _stockController.text = '0';
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              TextFormField(
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Item Description/ Detail',
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
                initialValue: _description,
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 40),

              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
