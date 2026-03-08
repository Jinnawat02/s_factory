import 'package:flutter/material.dart';
import 'package:s_factory/features/profile/mechanic_calendar.dart';
import 'package:s_factory/shared/widgets/nav_bar.dart';
import '../../shared/services/secure_storage_service.dart';

class Profile extends StatefulWidget {
  final dynamic user;

  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _currentRole = '';
  bool _isLoading = true;

  // For calendar variable

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    try {
      final role = await SecureStorageService().getRole();
      if (mounted) {
        if (role == null || role.isEmpty) {
          // แทนที่จะ throw exception อาจจะตั้งเป็น 'N/A' หรือ 'Guest'
          setState(() {
            _currentRole = 'Unknown';
            _isLoading = false;
          });
          return;
        }
        setState(() {
          _currentRole = role;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      debugPrint('Error loading role: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: _currentRole != 'mechanic' ? NavBar(
        title: user.name ?? 'Profile',
        leadingText: 'Back',
      ) : null,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _buildAvatar(user),
                  const SizedBox(height: 16),
                  _buildNameHeader(user),
                  const SizedBox(height: 24),
                  _buildInfoSection(user),

                  if (user.role == 'mechanic') ...[
                    const SizedBox(height: 24),
                    MechanicCalendar(mechanicEmail: user.email),
                  ],

                  if (_currentRole == 'admin') ...[
                    const SizedBox(height: 24),
                    _buildEditButton(),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildAvatar(dynamic user) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue.shade100,
            backgroundImage: NetworkImage(
              user.imageUrl ??
              'https://ui-avatars.com/api/?name=${Uri.encodeComponent(user.name)}&background=0D47A1&color=fff&size=200&bold=true'
            ),
          ),
          if (_currentRole == 'admin')
            const Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.edit, size: 18, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNameHeader(dynamic user) {
    return Column(
      children: [
        Text(
          user.name ?? 'ไม่ระบุชื่อ',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          user.email,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildInfoSection(dynamic user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildInfoTile(Icons.badge, 'บทบาทหลัก', user.role ?? 'N/A'),
          _buildInfoTile(
            Icons.phone,
            'เบอร์โทรศัพท์',
            user.tel ?? 'ไม่ได้ระบุ',
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('แก้ไขข้อมูลส่วนตัว'),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
