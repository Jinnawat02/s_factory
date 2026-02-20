import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s_factory/shared/widgets/nav_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: 'Test'),
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}