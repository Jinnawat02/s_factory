import 'package:flutter/material.dart';
import 'package:s_factory/features/profile/profile.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import '../../../dataconnect_generated/generated.dart';

class MechanicsList extends StatelessWidget {
  const MechanicsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<QueryResult<GetMechanicsData, void>>(
          future: ConnectorConnector.instance.getMechanics().execute(),
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
                final GetMechanicsUsers mechanic = mechanics[index];
                final name = mechanic.name ?? mechanic.email;
                // Generate a placeholder avatar based on the name
                final imgUrl =
                    'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=random';

                return mechanicsContainer(context, name, imgUrl, mechanic);
              },
            );
          },
        ),
      ),
    );
  }

  Widget mechanicsContainer(BuildContext context, String name, String imgUrl, GetMechanicsUsers mechanic) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Profile(user: mechanic),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blueGrey,
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
            ],
          ),
        ),
      ),
    );
  }
}
