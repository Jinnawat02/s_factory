import 'package:flutter/material.dart';
import 'package:s_factory/features/profile/mechanic_calendar.dart';
import 'package:s_factory/shared/widgets/nav_bar.dart';
import '../../dataconnect_generated/generated.dart';
import '../../shared/services/secure_storage_service.dart';
import 'edit_profile_page.dart';

class Profile extends StatefulWidget {
  final dynamic user;
  final bool isOwnProfile;
  final bool isShowOnlyCalendar;

  const Profile({
    super.key,
    required this.user,
    required this.isOwnProfile,
    required this.isShowOnlyCalendar,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _currentRole = '';
  bool _isLoading = true;
  late dynamic _user;

  // For calendar variable

  @override
  void initState() {
    super.initState();
    _user = widget.user;
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

  Future<void> _reloadUser() async {
    try {
      final response = await ConnectorConnector.instance
          .getUser(email: _user.email)
          .execute();

      if (mounted) {
        setState(() {
          _user = response.data.user;
        });
      }
    } catch (e) {
      debugPrint("Failed to reload user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _user;
    final ownProfile = widget.isOwnProfile;
    final showOnlyCalendar = widget.isShowOnlyCalendar;

    return Scaffold(
      appBar: ownProfile
          ? null
          : NavBar(title: user.name ?? 'Profile', leadingText: 'Back'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (showOnlyCalendar) ...[
                    MechanicCalendar(mechanicEmail: user.email),
                  ] else ... [
                    SizedBox(height: 30),
                    _buildAvatar(user),
                    SizedBox(height: 16),
                    _buildNameHeader(user),
                    SizedBox(height: 24),
                    _buildInfoSection(user),

                    if (_currentRole == 'admin' || ownProfile) ...[
                      const SizedBox(height: 24),
                      _buildEditButton(),
                    ],

                    if (user.role == 'mechanic' && !ownProfile) ...[
                      const SizedBox(height: 24),
                      MechanicCalendar(mechanicEmail: user.email),
                    ],

                    const SizedBox(height: 24),
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
                  'https://ui-avatars.com/api/?name=${Uri.encodeComponent(user.name)}&background=0D47A1&color=fff&size=200&bold=true',
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
          user.name ?? 'Unknown Name',
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
          _buildInfoTile(Icons.badge, 'Role', user.role ?? 'N/A'),
          _buildInfoTile(
            Icons.phone,
            'Phone Number',
            user.tel ?? 'Not specified',
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(user: _user),
              ),
            );

            if (result != null && mounted) {
              await _reloadUser(); // 🔄 reload profile from database
            }
          },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
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
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
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
