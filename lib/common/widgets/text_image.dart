import 'package:flutter/material.dart';

import 'asset_icon.dart';

class TextImage extends StatelessWidget {
  final String? assetPath;
  final double? imageWidth;
  final double? imageHeight;
  final String? text;
  final double textSize;
  final Color textColor;
  final double spaceBetween;
  final FontWeight fontWeight;
  final double textHeight;
  final Widget? child;
  final TextStyle? style;
  final Icon? icon;
  final bool? reverse;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Color? imageColor;
  final EdgeInsets padding;
  final Widget? textChild;
  final Axis? orientation;
  final bool isSvg;

  const TextImage({
    super.key,
    this.assetPath,
    this.imageWidth,
    this.imageHeight,
    this.text = '',
    this.textColor = Colors.white,
    this.textSize = 14,
    this.spaceBetween = 4,
    this.textHeight = 1.5,
    this.fontWeight = FontWeight.normal,
    this.child,
    this.style,
    this.icon,
    this.reverse = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.imageColor,
    this.padding = EdgeInsets.zero,
    this.textChild,
    this.isSvg = false,
    this.orientation = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: orientation == Axis.horizontal
          ? Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (!reverse!)
                  assetPath != null && assetPath!.isNotEmpty
                      ? isSvg
                          ? Image.asset(
                              assetPath!,
                              color: imageColor,
                              height: imageHeight,
                              width: imageWidth,
                            )
                          : AssetIcon.svg(
                              path: assetPath!,
                              color: imageColor,
                              height: imageHeight,
                            )
                      : icon != null
                          ? icon!
                          : const SizedBox.shrink(),
                if (!reverse!) SizedBox(width: spaceBetween),
                if (text != null)
                  Text(
                    text!,
                    style: style ?? TextStyle(fontSize: textSize, color: textColor, height: textHeight, fontWeight: fontWeight),
                  ),
                if (child != null) child!,
                if (textChild != null) textChild!,
                if (reverse!) SizedBox(width: spaceBetween),
                if (reverse!)
                  assetPath != null
                      ? Image.asset(
                          assetPath!,
                          height: imageHeight,
                          width: imageWidth,
                        )
                      : icon != null
                          ? icon!
                          : const SizedBox.shrink(),
              ],
            )
          : Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (!reverse!)
                  assetPath != null && assetPath!.isNotEmpty
                      ? Image.asset(
                          assetPath!,
                          color: imageColor,
                          height: imageHeight,
                          width: imageWidth,
                        )
                      : icon != null
                          ? icon!
                          : const SizedBox.shrink(),
                if (!reverse!) SizedBox(width: spaceBetween),
                if (text != null)
                  Text(
                    text!,
                    style: style ?? TextStyle(fontSize: textSize, color: textColor, height: textHeight, fontWeight: fontWeight),
                  ),
                if (child != null) child!,
                if (textChild != null) textChild!,
                if (reverse!) SizedBox(width: spaceBetween),
                if (reverse!)
                  assetPath != null
                      ? Image.asset(
                          assetPath!,
                          height: imageHeight,
                          width: imageWidth,
                        )
                      : icon != null
                          ? icon!
                          : const SizedBox.shrink(),
              ],
            ),
    );
  }
}
