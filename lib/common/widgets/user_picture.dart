import 'package:flutter/material.dart';

class UserPicture extends StatelessWidget {
  final String path;
  final double radius;
  final double borderWidth;

  const UserPicture.asset({super.key, required this.path, this.radius = 30, this.borderWidth = 5});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF121517),
      radius: radius,
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Image.asset(path),
      ),
    );
  }
}
