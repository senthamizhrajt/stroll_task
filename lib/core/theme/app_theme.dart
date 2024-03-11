import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    //scaffoldBackgroundColor: const Color(0xFFE8EAED),
    scaffoldBackgroundColor: Colors.white,
    dividerColor: const Color(0x1F000000),
    dividerTheme: const DividerThemeData(color: Color(0x1F000000)),
    shadowColor: ThemeData.light().shadowColor.withOpacity(0.3),
    fontFamily: 'Nova',
    checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: Colors.green, width: 2),
        fillColor: MaterialStateColor.resolveWith((states) {
          if (!states.contains(MaterialState.selected)) {
            return Colors.transparent;
          }
          return Colors.green;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
    chipTheme: ChipThemeData(
        backgroundColor: AppColors.accentColorLight,
        surfaceTintColor: Colors.transparent,
        side: BorderSide.none,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(surfaceTintColor: MaterialStateProperty.all(Colors.transparent), iconColor: MaterialStateProperty.all(Colors.black))),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.primaryColor.withOpacity(0.1), hintStyle: const TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF666666))),
    bottomAppBarTheme: BottomAppBarTheme(color: AppColors.accentColor.withOpacity(0.1), elevation: 0),
    bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary, //  <-- dark text for light background
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(color: Colors.black, fontFamily: 'Nova'),
      subtitleTextStyle: TextStyle(fontFamily: 'Nova', color: Colors.black87),
    ),
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(1000), topRight: Radius.circular(1000)),
          borderSide: BorderSide(color: AppColors.accentColor, width: 3), // Indicator height
          insets: EdgeInsets.symmetric(horizontal: 8), // Indicator width
        ),
        dividerColor: Color(0x1F000000),
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        labelPadding: EdgeInsets.symmetric(horizontal: 24),
        tabAlignment: TabAlignment.start,
        labelStyle: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nova')),
    dialogBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black, fontFamily: 'Nova'),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: (Platform.isAndroid ? Brightness.dark : Brightness.light),
          statusBarBrightness: (Platform.isAndroid ? Brightness.dark : Brightness.light),
        ),
        iconTheme: const IconThemeData(color: Colors.black)),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor, primary: AppColors.primaryColorLight, brightness: Brightness.light),
    hintColor: Colors.black.withOpacity(0.7),
    dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nova', fontSize: 18, color: Colors.black),
        contentTextStyle: TextStyle(fontFamily: 'Nova', color: Colors.black),
        surfaceTintColor: Colors.transparent),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor.withOpacity(0.5),
      selectionHandleColor: AppColors.primaryColor,
    ),
    secondaryHeaderColor: Colors.black.withOpacity(0.7),
    cardColor: AppColors.primaryColor.withOpacity(0.3),
    cardTheme: CardTheme(
      color: AppColors.primaryColor.withOpacity(0.3),
      elevation: 0,
    ),
    popupMenuTheme: const PopupMenuThemeData(
        color: Color(0xFFCECECE),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: MaterialStatePropertyAll(TextStyle(color: Colors.black, fontFamily: 'Nova')),
        textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Nova')),
    iconTheme: const IconThemeData(color: Colors.black),
    radioTheme: RadioThemeData(
        overlayColor: MaterialStateColor.resolveWith((states) => AppColors.accentColor.withOpacity(0.1)),
        fillColor: MaterialStateColor.resolveWith((states) => AppColors.accentColor)),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black, fontSize: 57.0),
      displayMedium: TextStyle(color: Colors.black, fontSize: 45.0),
      displaySmall: TextStyle(color: Colors.black, fontSize: 36.0),
      headlineLarge: TextStyle(color: Colors.black, fontSize: 32.0),
      headlineMedium: TextStyle(color: Colors.black, fontSize: 28.0),
      headlineSmall: TextStyle(color: Colors.black, fontSize: 24.0),
      titleLarge: TextStyle(color: Colors.black, fontSize: 20.0),
      titleMedium: TextStyle(color: Colors.black, fontSize: 16.0),
      titleSmall: TextStyle(color: Colors.black, fontSize: 14.0),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16.0),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 14.0),
      bodySmall: TextStyle(color: Colors.black, fontSize: 12.0),
      labelLarge: TextStyle(color: Colors.black, fontSize: 14.0),
      labelMedium: TextStyle(color: Colors.black, fontSize: 12.0),
      labelSmall: TextStyle(color: Colors.black, fontSize: 11.0),
    ),
  );
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    fontFamily: 'Nova',
    hintColor: Colors.white.withOpacity(0.7),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor, primary: AppColors.primaryColorLight, brightness: Brightness.dark),
    scaffoldBackgroundColor: const Color(0xFF0D0E12),
    dividerColor: const Color(0x1FFFFFFF),
    dividerTheme: const DividerThemeData(color: Color(0x1FFFFFFF)),
    shadowColor: ThemeData.dark().shadowColor.withOpacity(0.3),
    bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Color(0xFF2A2C2E)),
    checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: Colors.green, width: 2),
        fillColor: MaterialStateColor.resolveWith((states) {
          if (!states.contains(MaterialState.selected)) {
            return Colors.transparent;
          }
          return Colors.green;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
    chipTheme: ChipThemeData(
        surfaceTintColor: Colors.transparent,
        side: BorderSide.none,
        elevation: 0,
        //backgroundColor: AppColors.accentColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(surfaceTintColor: MaterialStateProperty.all(Colors.transparent), iconColor: MaterialStateProperty.all(Colors.white))),
    inputDecorationTheme:
        const InputDecorationTheme(hintStyle: TextStyle(color: Colors.white54, fontWeight: FontWeight.w400), fillColor: Color(0xFF2A2C2E)),
    bottomAppBarTheme: const BottomAppBarTheme(elevation: 0, color: Color(0xFF0F1115)),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary, //  <-- dark text for light background
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(color: Colors.white, fontFamily: 'Nova'),
      subtitleTextStyle: TextStyle(fontFamily: 'Nova', color: Colors.white70),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor.withOpacity(0.5),
      selectionHandleColor: AppColors.primaryColor,
    ),
    appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontFamily: 'Nova'),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: (Platform.isAndroid ? Brightness.light : Brightness.dark),
          statusBarBrightness: (Platform.isAndroid ? Brightness.light : Brightness.dark),
        ),
        backgroundColor: const Color(0xFF121418),
        iconTheme: const IconThemeData(color: Colors.white)),
    popupMenuTheme: const PopupMenuThemeData(
        color: Color(0xFF3E4042),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white, fontFamily: 'Nova')),
        textStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'Nova')),
    secondaryHeaderColor: Colors.white.withOpacity(0.7),
    cardColor: const Color(0xFF232A2E),
    cardTheme: const CardTheme(color: Color(0xFF232A2E)),
    tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(1000), topRight: Radius.circular(1000)),
          borderSide: BorderSide(color: AppColors.accentColor, width: 2), // Indicator height
          insets: EdgeInsets.symmetric(horizontal: 12), // Indicator width
        ),
        dividerColor: Color(0x1FFFFFFF),
        labelColor: Colors.white,
        indicatorColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        labelPadding: EdgeInsets.symmetric(horizontal: 24),
        tabAlignment: TabAlignment.start,
        labelStyle: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nova')),
    dialogBackgroundColor: const Color(0xFF2A2C2E),
    iconTheme: const IconThemeData(color: Colors.white),
    dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nova', fontSize: 18, color: Colors.white),
        contentTextStyle: TextStyle(fontFamily: 'Nova', color: Colors.white),
        surfaceTintColor: Colors.transparent),
    radioTheme: RadioThemeData(
        overlayColor: MaterialStateColor.resolveWith((states) => AppColors.accentColor),
        fillColor: MaterialStateColor.resolveWith((states) => AppColors.accentColor)),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontSize: 57.0),
      displayMedium: TextStyle(color: Colors.white, fontSize: 45.0),
      displaySmall: TextStyle(color: Colors.white, fontSize: 36.0),
      headlineLarge: TextStyle(color: Colors.white, fontSize: 32.0),
      headlineMedium: TextStyle(color: Colors.white, fontSize: 28.0),
      headlineSmall: TextStyle(color: Colors.white, fontSize: 24.0),
      titleLarge: TextStyle(color: Colors.white, fontSize: 20.0),
      titleMedium: TextStyle(color: Colors.white, fontSize: 16.0),
      titleSmall: TextStyle(color: Colors.white, fontSize: 14.0),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16.0),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 14.0),
      bodySmall: TextStyle(color: Colors.white, fontSize: 12.0),
      labelLarge: TextStyle(color: Colors.white, fontSize: 14.0),
      labelMedium: TextStyle(color: Colors.white, fontSize: 12.0),
      labelSmall: TextStyle(color: Colors.white, fontSize: 11.0),
    ),
  );
}
