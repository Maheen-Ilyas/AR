import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        height: 150,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 32, 53, 96),
              Color.fromARGB(255, 75, 108, 183),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 15,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
