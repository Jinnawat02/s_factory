import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s_factory/features/profile/profile.dart';

import '../../../mock/mechanics_mock_data.dart';

class MechanicsList extends StatelessWidget {
  const MechanicsList({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> mechanicListName = [];
    List<String> mechanicListImageUrl = [];

    for (var item in MechanicsMockData.mechanics) {
      mechanicListName.add(item['name'].toString());
      mechanicListImageUrl.add(item['imageUrl'].toString());
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: mechanicListName.length,
          itemBuilder: (context, index) {
            return mechanicsContainer(context, mechanicListName[index], mechanicListImageUrl[index]);
          },
        ),
      ),
    );
  }

  Widget mechanicsContainer(BuildContext context, String name, String imgUrl) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Profile(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blueGrey,
          ),
          width: .infinity,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.5),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(imgUrl),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
