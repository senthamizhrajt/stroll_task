import 'package:flutter/material.dart';

class UserPicture extends StatelessWidget {
  final String path;
  final double radius;
  final double borderWidth;
  final bool enableOverlay;
  final String? name;

  const UserPicture.asset({super.key, required this.path, this.radius = 30, this.borderWidth = 5, this.enableOverlay = false, this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFF121517),
          radius: radius,
          child: Padding(
            padding: EdgeInsets.all(borderWidth),
            child: Image.asset(path),
          ),
        ),
        if (enableOverlay)
          Positioned(
            left: -8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000), color: Colors.black87),
              child: const Text('👏 24', style: TextStyle(fontSize: 8),),
            ),
          ),
        if (enableOverlay && name != null)
          Positioned.fill(
            bottom: -10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000), color: Colors.black),
                child: Text(name!, style: const TextStyle(fontSize: 8),),
              ),
            ),
          ),
      ],
    );
  }
}
