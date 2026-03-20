/// Screen for administrators to onboard new employees.
///
/// Provides a form to capture user details, assign a role, and optionally
/// upload a profile image. It submits this data to Firebase Authentication
/// and Data Connect.
///
/// @author Thanat Phadinkaew
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/widgets/nav_bar.dart';
import '../../dataconnect_generated/generated.dart';
import '../../shared/utils/storage_service.dart';
import '../../shared/utils/snackbar_utils.dart';

import 'package:firebase_auth/firebase_auth.dart';

/// A screen that captures new user information and registers them in the system.
class AddUserPage extends StatefulWidget {
  /// Creates an [AddUserPage].
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
      String? uploadedImageUrl;
      if (_pickedImage != null) {
        uploadedImageUrl = await StorageService.uploadImage(
          _pickedImage!,
          'users',
        );
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _email.trim(),
            password: _password.trim(),
          );

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
        SnackBarUtils.showSuccess(context, 'Employee added successfully');
        Navigator.pop(context, true);
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Account already exists.';
      }

      if (mounted) {
        SnackBarUtils.showError(context, message);
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
    final imageSize = screenWidth * 0.45; // 45% of screen width

    return Scaffold(
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
                      color: Colors.white.withOpacity(
                        0.1,
                      ), // changed for dark mode
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[600]!,
                        width: 2,
                      ), // matched
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
                            color: Colors.white70,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // EMAIL
              const Text(
                'EMAIL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: const TextStyle(color: Colors.white),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                obscureText: _obscurePassword,
                decoration: _inputDecoration('Password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white54,
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
              const Text(
                'NAME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Full Name'),
                onChanged: (value) => _name = value,
              ),
              const SizedBox(height: 24),

              // ROLE
              const Text(
                'ROLE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF2E2E32), // match background
                style: const TextStyle(color: Colors.white),
                initialValue: _selectedRole,
                hint: const Text(
                  'Select Role',
                  style: TextStyle(color: Colors.white54),
                ),
                decoration: _inputDecoration(''),
                items: _roles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(
                      role,
                      style: const TextStyle(color: Colors.white),
                    ),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
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
                      backgroundColor: Colors.deepOrange, // match add item
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // match add item
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
                            'Save', // match add item
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
      hintStyle: const TextStyle(color: Colors.white54),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 2),
      ),
    );
  }
}
