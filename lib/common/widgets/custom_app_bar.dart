import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Brightness brightness;
  final String? subtitle;
  final Widget? subtitleWidget;
  final bool? centerTitle;
  final double titleTextSize;
  final double subtitleTextSize;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final double elevation;
  final PreferredSize? bottom;
  final double height;
  final ShapeBorder? shape;
  final bool showBottom;
  final bool isClosable;
  final double? titleSpacing;
  final Widget? leading;
  final double? leadingWidth;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.actions,
    this.brightness = Brightness.dark,
    this.centerTitle,
    this.titleTextSize = 20,
    this.subtitleTextSize = 14,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.elevation = 4.0,
    this.bottom,
    this.leading,
    this.leadingWidth,
    this.height = kToolbarHeight,
    this.shape,
    this.showBottom = true,
    this.isClosable = false,
    this.titleSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      titleSpacing: titleSpacing,
      bottom: !showBottom ? null : bottom ?? const PreferredSize(preferredSize: Size(0, 1), child: Divider(thickness: 1, height: 1)),
      shape: shape,
      elevation: 0,
      shadowColor: Theme.of(context).shadowColor,
      backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: centerTitle != null ? centerTitle! : Platform.isIOS,
      leading: leading,
      /*leading: ModalRoute.of(context)!.canPop || navButtonIcon != null
          ? IconButton(
              padding: const EdgeInsets.all(16),
              icon: navButtonIcon == null
                  ? isClosable
                      ? Icon(
                          Icons.close,
                          color: Theme.of(context).appBarTheme.iconTheme!.color,
                        )
                      : (Platform.isAndroid
                          ? Icon(
                              Icons.arrow_back_rounded,
                              color: Theme.of(context).appBarTheme.iconTheme!.color,
                            )
                          : Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Theme.of(context).appBarTheme.iconTheme!.color,
                            ))
                  : navButtonIcon!,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : const SizedBox.shrink(),*/
      //leadingWidth: ModalRoute.of(context)!.canPop || navButtonIcon != null ? null : 0,
      leadingWidth: leadingWidth,
      iconTheme: Theme.of(context).appBarTheme.iconTheme,
      title: title != null
          ? Column(
              crossAxisAlignment: centerTitle != null
                  ? (centerTitle! ? CrossAxisAlignment.center : CrossAxisAlignment.start)
                  : (Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start),
              children: [
                Text(title!, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: titleTextSize, fontWeight: FontWeight.w500)),
                subtitleWidget ??
                    (subtitle != null && subtitle!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              subtitle!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: subtitleTextSize, color: Theme.of(context).secondaryHeaderColor),
                            ))
                        : const SizedBox.shrink())
              ],
            )
          : titleWidget ?? const SizedBox.shrink(),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
