import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? color;
  final Color? highlightColor;
  final double? width;
  final double? height;
  final String? text;
  final bool isProgressing;
  final bool shrink;
  final double verticalPadding;
  final double horizontalPadding;
  final bool isCompact;
  final double borderRadius;
  final TextStyle? style;
  final double progressIndicatorSize;
  final Color progressIndicatorColor;
  final BorderSide borderSide;
  final double? elevation;

  const AppButton.primary({
    super.key,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.highlightColor = AppColors.primaryColorDark,
    this.child,
    this.width = 96,
    this.height = 24,
    this.text,
    this.elevation,
    this.isProgressing = false,
    this.shrink = true,
    this.verticalPadding = 16.0,
    this.horizontalPadding = 16.0,
    this.isCompact = false,
    this.borderRadius = 16,
    this.style,
    this.progressIndicatorSize = 20,
    this.progressIndicatorColor = Colors.white,
    this.borderSide = BorderSide.none,
  });

  const AppButton.accent({
    super.key,
    required this.onPressed,
    this.color = AppColors.accentColor,
    this.highlightColor = AppColors.accentColorDark,
    this.child,
    this.width = 96,
    this.height = 24,
    this.text,
    this.elevation,
    this.isProgressing = false,
    this.shrink = true,
    this.verticalPadding = 16.0,
    this.horizontalPadding = 16.0,
    this.isCompact = false,
    this.borderRadius = 16,
    this.style,
    this.progressIndicatorSize = 20,
    this.progressIndicatorColor = Colors.white,
    this.borderSide = BorderSide.none,
  });

  const AppButton.compactAccent({
    super.key,
    required this.onPressed,
    this.color = AppColors.accentColor,
    this.highlightColor = AppColors.accentColorDark,
    this.child,
    this.width,
    this.height,
    this.text,
    this.elevation,
    this.isProgressing = false,
    this.shrink = true,
    this.verticalPadding = 0.0,
    this.horizontalPadding = 0.0,
    this.isCompact = true,
    this.borderRadius = 12,
    this.style,
    this.progressIndicatorSize = 20,
    this.progressIndicatorColor = Colors.white,
    this.borderSide = BorderSide.none,
  });

  const AppButton.compactPrimary({
    super.key,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.highlightColor = AppColors.primaryColorDark,
    this.child,
    this.width,
    this.height,
    this.text,
    this.elevation,
    this.isProgressing = false,
    this.shrink = true,
    this.verticalPadding = 0.0,
    this.horizontalPadding = 0.0,
    this.isCompact = true,
    this.borderRadius = 12,
    this.style,
    this.progressIndicatorSize = 20,
    this.progressIndicatorColor = Colors.white,
    this.borderSide = BorderSide.none,
  });

  const AppButton.flatAccent({
    super.key,
    required this.onPressed,
    this.color = Colors.transparent,
    this.highlightColor = AppColors.accentColorLight,
    this.child,
    this.width,
    this.height,
    this.text,
    this.elevation,
    this.isProgressing = false,
    this.shrink = true,
    this.verticalPadding = 16.0,
    this.horizontalPadding = 16.0,
    this.isCompact = true,
    this.borderRadius = 12,
    this.style = const TextStyle(color: AppColors.accentColor),
    this.progressIndicatorSize = 20,
    this.progressIndicatorColor = Colors.white,
    this.borderSide = BorderSide.none,
  });

  @override
  State<StatefulWidget> createState() => AppButtonState();
}

class AppButtonState extends State<AppButton> {
  bool isTapped = false;
  double spreadRadius = 1.0;
  Offset offset = const Offset(3, 3);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: widget.isCompact ? widget.height : null,
      minWidth: widget.isCompact ? widget.width : null,
      elevation: widget.color == Colors.transparent ? 0 : widget.elevation ?? 6,
      highlightElevation: widget.color == Colors.transparent ? 0 : widget.elevation ?? 12,
      textColor: Colors.white,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding, horizontal: widget.horizontalPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius), side: widget.borderSide),
      highlightColor: widget.highlightColor ?? AppColors.primaryColorDark,
      color: widget.color ?? AppColors.primaryColorLight,
      onPressed: !widget.isProgressing ? widget.onPressed : () {},
      disabledColor: widget.color == Colors.transparent
          ? null
          : widget.color != null
              ? widget.color!.withOpacity(0.5)
              : AppColors.primaryColor.withOpacity(0.5),
      child: Container(
        width: widget.shrink ? null : double.maxFinite,
        constraints: widget.isCompact ? null : const BoxConstraints(minWidth: 96, minHeight: 24),
        child: AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            duration: const Duration(milliseconds: 200),
            child: widget.text != null
                    ? Text(widget.text!, style: widget.style)
                    : widget.child),
      ),
    );
  }
}

Color darken(Color color, ShadowDegree degree) {
  double amount = degree == ShadowDegree.dark ? 0.3 : 0.12;
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

enum ShadowDegree { light, dark }
