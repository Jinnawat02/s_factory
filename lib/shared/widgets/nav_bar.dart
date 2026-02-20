import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? leadingText;
  final VoidCallback? onLeadingPressed;

  const NavBar({
    super.key,
    required this.title,
    this.leadingText,
    this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      elevation: 0.5,

      leadingWidth: leadingText != null ? 100 : null,
      leading: leadingText != null ? TextButton(
        onPressed: onLeadingPressed ?? () => Navigator.pop(context),
        child: Text(
          leadingText!,
          style: const TextStyle(color: Colors.white),
        ),
      ) : null, // for leading to previous page

      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          color: Colors.white,
          onPressed: () => FirebaseAuth.instance.signOut(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}