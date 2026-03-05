import 'package:flutter/material.dart';
import '../../shared/widgets/nav_bar.dart';
import '../../dataconnect_generated/generated.dart';

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
  bool _hasPicture = false;

  final List<String> _roles = ['Admin', 'Mechanic', 'Staff'];

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ConnectorConnector.instance
          .createUser(
            email: _email,
            password: _password,
            name: _name.isEmpty ? null : _name,
            role: _selectedRole,
            tel: _tel.isEmpty ? null : _tel,
          )
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
                  onTap: () {
                    setState(() {
                      _hasPicture = !_hasPicture;
                    });
                  },
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: _hasPicture
                        ? const Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.person_outline,
                            size: 40,
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
