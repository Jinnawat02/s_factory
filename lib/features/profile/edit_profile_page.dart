import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/widgets/nav_bar.dart';
import '../../dataconnect_generated/generated.dart';
import '../../shared/utils/storage_service.dart';
import '../../shared/utils/snackbar_utils.dart';

class EditProfilePage extends StatefulWidget {
  final dynamic user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String _tel;
  String? _currentImageUrl;
  XFile? _pickedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name ?? '';
    _tel = widget.user.tel ?? '';
    _currentImageUrl = widget.user.imageUrl;
  }

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
        SnackBarUtils.showError(context, 'Cannot pick image: $e');
      }
    }
  }

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
              title: const Text('Take a Photo'),
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      String? uploadedImageUrl = _currentImageUrl;
      if (_pickedImage != null) {
        uploadedImageUrl = await StorageService.uploadImage(
          _pickedImage!,
          'users',
        );
      }

      await ConnectorConnector.instance
          .updateUser(email: widget.user.email)
          .name(_name)
          .tel(_tel)
          .imageUrl(uploadedImageUrl)
          .execute();

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Profile updated successfully');
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'Error: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.25;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E22), // Matched dark theme
      appBar: const NavBar(title: 'Edit Profile', leadingText: 'Back'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
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
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[600]!, width: 2),
                    ),
                    child: ClipOval(child: _buildImageWidget()),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              _buildLabel('EMAIL'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.user.email,
                enabled: false,
                style: const TextStyle(color: Colors.white70),
                decoration: _inputDecoration(
                  'Email',
                ).copyWith(fillColor: Colors.black12, filled: true),
              ),
              const SizedBox(height: 24),

              _buildLabel('NAME'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _name,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Full Name'),
                onChanged: (value) => _name = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter name' : null,
              ),
              const SizedBox(height: 24),

              _buildLabel('PHONE'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _tel,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration('Phone Number'),
                onChanged: (value) => _tel = value,
              ),
              const SizedBox(height: 48),

              Center(
                child: SizedBox(
                  width: 100,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _buildImageWidget() {
    if (_pickedImage != null) {
      return kIsWeb
          ? Image.network(_pickedImage!.path, fit: BoxFit.cover)
          : Image.file(File(_pickedImage!.path), fit: BoxFit.cover);
    }
    if (_currentImageUrl != null && _currentImageUrl!.isNotEmpty) {
      return Image.network(_currentImageUrl!, fit: BoxFit.cover);
    }
    return const Icon(Icons.person_outline, size: 60, color: Colors.white70);
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
