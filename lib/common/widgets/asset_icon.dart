import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetIcon extends StatelessWidget {
  final String path;
  final Color? color;
  final double opacity;
  final double? height;
  bool isSvg = false;

  AssetIcon({
    super.key,
    required this.path,
    this.color,
    this.opacity = 1.0,
    this.height,
  }) {
    isSvg = false;
  }

  AssetIcon.svg({
    super.key,
    required this.path,
    this.color,
    this.opacity = 1.0,
    this.height,
  }) {
    isSvg = true;
  }

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        path,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(
                color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(opacity) : Colors.black.withOpacity(opacity)),
                BlendMode.srcIn,
              )
            : null,
      );
    }
    return Image.asset(path,
        height: height,
        color: color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(opacity) : Colors.black.withOpacity(opacity)));
  }
}
