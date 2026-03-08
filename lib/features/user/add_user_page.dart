import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/widgets/nav_bar.dart';
import '../../dataconnect_generated/generated.dart';
import '../../shared/utils/storage_service.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _name = '';
  String _tel = '';
  String? _selectedRole;
  bool _isLoading = false;
  bool _obscurePassword = true;
  XFile? _pickedImage;

  final List<String> _roles = ['admin', 'mechanic', 'staff'];

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
        ).showSnackBar(SnackBar(content: Text('Cannot pick image: $e')));
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
      String? uploadedImageUrl;
      if (_pickedImage != null) {
        uploadedImageUrl = await StorageService.uploadImage(
          _pickedImage!,
          'users',
        );
      }

      await ConnectorConnector.instance
          .createUser(
            email: _email,
            password: _password,
            name: _name,
            role: _selectedRole ?? '',
            tel: _tel,
          )
          .imageUrl(uploadedImageUrl)
          .execute();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Employee added successfully')),
        );
        Navigator.pop(context, true); // true = user was created
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
    final imageSize = screenWidth * 0.45; // 45% of screen width

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const NavBar(title: 'Add Employee', leadingText: 'Back'),
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
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: _pickedImage != null
                        ? ClipOval(
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
                        : const Icon(
                            Icons.person_outline,
                            size: 60,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // EMAIL
              const Text(
                'EMAIL',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) return 'Please enter a valid email';
                  return null;
                },
                onChanged: (value) => _email = value,
              ),
              const SizedBox(height: 24),

              // PASSWORD
              const Text(
                'PASSWORD',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: _obscurePassword,
                decoration: _inputDecoration('Password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onChanged: (value) => _password = value,
              ),
              const SizedBox(height: 24),

              // NAME
              const Text('NAME', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _inputDecoration('Full Name'),
                onChanged: (value) => _name = value,
              ),
              const SizedBox(height: 24),

              // ROLE
              const Text('ROLE', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedRole,
                hint: const Text('Select Role'),
                decoration: _inputDecoration(''),
                items: _roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() => _selectedRole = newValue);
                },
                validator: (value) =>
                    value == null ? 'Please select a role' : null,
              ),
              const SizedBox(height: 24),

              // TEL
              const Text(
                'PHONE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.black,
                            ),
                          )
                        : const Text(
                            'Add',
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
    );
  }
}
