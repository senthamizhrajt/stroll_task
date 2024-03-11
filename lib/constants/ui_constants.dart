import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/widgets/asset_icon.dart';
import '../common/widgets/fade_in_image.dart';
import '../data/model/user.dart';

class UiConstants {
  static final spaceRestrictedInputFormatter = [FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))];

  static getCurrencyText(String value, String currencySymbol, double fontSize,
      {Color? textColor, double? height = 1.8, FontWeight? weight}) {
    return RichText(
      text: TextSpan(
          style: TextStyle(fontFamily: 'Nova', color: textColor, height: height, fontWeight: weight),
          children: [
            TextSpan(text: currencySymbol, style: TextStyle(fontSize: (fontSize / 1.6))),
            TextSpan(text: value, style: TextStyle(fontSize: fontSize)),
          ]),
    );
  }

  static Widget getProfilePicture(User? user, {double radius = 12, double? fontSize, Color? defaultIconColor}) {
    radius = radius == 0 ? double.maxFinite : radius;
    return CircleAvatar(
        radius: radius,
        //foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: user != null && user.profilePictureUrl != null
            ? ClipOval(
                child: FadeInImage(
                  image: NetworkImage(user.profilePictureUrl!),
                  placeholder: const AssetImage("assets/images/icons/icon_user.png"),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/images/icons/icon_user.png", color: defaultIconColor);
                  },
                ),
              )
            : Image.asset('assets/images/svg/icons/icon_user.png', color: defaultIconColor));
  }

  static Widget fadeInImage(
    BuildContext context,
    String? url, {
    double? width,
    double? height,
    double? placeHolderWidth,
    double? placeHolderHeight,
    BoxFit? fit,
  }) {
    if (url == null || url.isEmpty) {
      return Container(
        height: height,
        alignment: Alignment.center,
        child: AssetIcon.svg(
            path: 'assets/images/icons/icon_file_error.svg', height: placeHolderHeight ?? placeHolderWidth ?? height),
      );
    }
    return NewFadeInImage(
      width: width,
      height: height,
      placeholder: const AssetImage('assets/images/remove/icon_loader.png'),
      placeHolderWidth: placeHolderWidth,
      placeHolderHeight: placeHolderHeight,
      placeholderFit: BoxFit.contain,
      fit: fit,
      image: NetworkImage(url),
      imageErrorBuilder: (context, error, trace) {
        return Align(
            child: AssetIcon.svg(
                path: 'assets/images/icons/icon_file_error.svg',
                height: placeHolderHeight ?? placeHolderWidth ?? height));
      },
    );
  }
}
