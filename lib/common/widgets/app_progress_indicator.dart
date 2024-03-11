import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  final double? width;
  final double? height;
  Color? color;
  EdgeInsets? padding;

  AppProgressIndicator({
    super.key,
    this.width = 32,
    this.height = 32,
    this.color = Colors.white,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: color,
      ),
    );
  }
}
