import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? leadingText;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;

  const NavBar({
    super.key,
    required this.title,
    this.leadingText,
    this.onLeadingPressed,
    this.actions,
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
      leading: leadingText != null
          ? TextButton(
              onPressed: onLeadingPressed ?? () => Navigator.pop(context),
              child: Text(
                leadingText!,
                style: const TextStyle(color: Colors.white),
              ),
            )
          : null, // for leading to previous page
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
