import 'package:flutter/material.dart';
import 'package:s_factory/features/profile/profile.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';

import 'package:s_factory/features/user/add_user_page.dart';

class MechanicsList extends StatefulWidget {
  final String? role;

  const MechanicsList({super.key, this.role});

  @override
  State<MechanicsList> createState() => _MechanicsListState();
}

class _MechanicsListState extends State<MechanicsList> {
  late Future<QueryResult<GetMechanicsData, void>> _futureMechanics;

  @override
  void initState() {
    super.initState();
    _loadMechanics();
  }

  void _loadMechanics() {
    setState(() {
      _futureMechanics = ConnectorConnector.instance.getMechanics().execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.role == 'admin'
          ? FloatingActionButton(
              onPressed: () async {
                final added = await Navigator.push<bool?>(
                  context,
                  MaterialPageRoute(builder: (context) => const AddUserPage()),
                );
                if (added == true) {
                  _loadMechanics();
                }
              },
              tooltip: 'Add Employee',
              child: const Icon(Icons.add),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<QueryResult<GetMechanicsData, void>>(
          future: _futureMechanics,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading mechanics: ${snapshot.error}'),
              );
            }

            final mechanics = snapshot.data?.data.users ?? [];

            if (mechanics.isEmpty) {
              return const Center(child: Text('No mechanics found.'));
            }

            return ListView.builder(
              itemCount: mechanics.length,
              itemBuilder: (context, index) {
                final dynamic mechanic = mechanics[index];
                final name = mechanic.name ?? mechanic.email;
                // Generate a placeholder avatar based on the name
                final imgUrl = mechanic.imageUrl ??
                    'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=0D47A1&color=fff&size=200&bold=true';

                return mechanicsContainer(context, name, imgUrl, mechanic);
              },
            );
          },
        ),
      ),
    );
  }

  Widget mechanicsContainer(
    BuildContext context,
    String name,
    String imgUrl,
    dynamic mechanic,
  ) {
    return Card(
      child: InkWell(
        onTap: () async {
          final deleted = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (context) => Profile(user: mechanic)),
          );
          if (deleted == true && mounted) {
            _loadMechanics();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
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
                  backgroundColor: Colors.black,
                  backgroundImage: NetworkImage(imgUrl),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
