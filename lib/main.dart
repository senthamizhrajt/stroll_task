import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stroll_task/features/splash_screen.dart';

import 'common/config/app_config.dart';
import 'common/providers/app_state_provider.dart';
import 'common/routes/route_utils.dart';
import 'common/utils/device_utils.dart';
import 'core/l10n/localization_service.dart';
import 'core/theme/app_theme.dart';
import 'data/storage/preference_manager.dart';
import 'features/profile/ui/profile_onboarding_screen.dart';

Future<void> mainDelegate() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await PreferenceManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    int theme = 0;
    String language = 'en';
    final AppStateProvider appStateProvider = AppStateProvider(theme: theme);
    appStateProvider.updateLanguage(language);

    DeviceUtils.initialize(context);

    return ChangeNotifierProvider<AppStateProvider>(
      create: (context) => appStateProvider,
      child: Consumer<AppStateProvider>(builder: (context, appState, child) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // status bar color
          statusBarBrightness: appState.theme == Brightness.dark
              ? (Platform.isAndroid ? Brightness.light : Brightness.dark)
              : (Platform.isAndroid ? Brightness.dark : Brightness.light), //status bar brigtness
          statusBarIconBrightness: appState.theme == Brightness.dark
              ? (Platform.isAndroid ? Brightness.light : Brightness.dark)
              : (Platform.isAndroid ? Brightness.dark : Brightness.light), //status barIcon Brightness
          systemNavigationBarIconBrightness: appState.theme == Brightness.dark
              ? (Platform.isAndroid ? Brightness.light : Brightness.dark)
              : (Platform.isAndroid ? Brightness.dark : Brightness.light), //navigation bar icon
        ));

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AppStateProvider>(create: (_) => AppStateProvider()),
          ],
          child: MaterialApp(
            title: AppConfig.appName,
            theme: appState.theme == Brightness.dark ? AppTheme.dark : AppTheme.light,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
              AppLocalizations.fileDelegate
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(appState.languageCode),
            onGenerateRoute: RouteUtils.onGenerateRoute,
            home: _getLaunchScreen(),
          ),
        );
      }),
    );
  }

  _getLaunchScreen() {
    return const ProfileOnBoardingScreen();
  }
}
