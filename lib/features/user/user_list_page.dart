import 'package:flutter/material.dart';
import 'package:s_factory/features/profile/profile.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';

import 'package:s_factory/features/user/add_user_page.dart';

class UserListPage extends StatefulWidget {
  final String? role;

  const UserListPage({super.key, this.role});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<QueryResult<ListUsersData, void>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      _futureUsers = ConnectorConnector.instance.listUsers().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: widget.role == 'admin'
            ? FloatingActionButton(
                onPressed: () async {
                  final added = await Navigator.push<bool?>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUserPage(),
                    ),
                  );
                  if (added == true) {
                    _loadUsers();
                  }
                },
                tooltip: 'Add Employee',
                child: const Icon(Icons.add),
              )
            : null,
        body: Column(
          children: [
            Container(
              color: Colors.transparent, // Removed white background
              child: const TabBar(
                labelColor: Colors.white, // Selected text
                unselectedLabelColor: Colors.white54, // Unselected text
                indicatorColor: Colors.deepOrange, // Keep the orange indicator
                tabs: [
                  Tab(text: 'Mechanics'),
                  Tab(text: 'Staff'),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<QueryResult<ListUsersData, void>>(
                future: _futureUsers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading users: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final allUsers = snapshot.data?.data.users ?? [];

                  // Filter out admins
                  final mechanics = allUsers
                      .where((u) => u.role == 'mechanic')
                      .toList();
                  final staff = allUsers
                      .where((u) => u.role == 'staff')
                      .toList();

                  return TabBarView(
                    children: [
                      _buildUserList(mechanics, 'mechanic'),
                      _buildUserList(staff, 'staff'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(List<ListUsersUsers> users, String emptyMessageRole) {
    if (users.isEmpty) {
      return Center(
        child: Text(
          'No $emptyMessageRole found.',
          style: const TextStyle(color: Colors.white54),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final name = user.name ?? user.email;
          final imgUrl =
              user.imageUrl ??
              'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=random';

          return _userContainer(context, name, imgUrl, user);
        },
      ),
    );
  }

  Widget _userContainer(
    BuildContext context,
    String name,
    String imgUrl,
    dynamic user,
  ) {
    return Card(
      color: Colors.transparent, // Let the container drive the color
      elevation: 0,
      child: InkWell(
        onTap: () async {
          final deleted = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (context) => Profile(user: user)),
          );
          if (deleted == true && mounted) {
            _loadUsers();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white.withOpacity(0.1), // Adjusted for dark theme
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          width: double.infinity,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.5),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(imgUrl),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.role == 'admin')
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => _confirmDeleteUser(context, user),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDeleteUser(BuildContext context, dynamic user) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete ${user.name ?? user.email}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      try {
        await ConnectorConnector.instance
            .deleteUser(email: user.email)
            .execute();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User deleted successfully')),
          );
          _loadUsers();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting user: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
