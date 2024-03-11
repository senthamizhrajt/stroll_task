import 'package:flutter/material.dart';
import 'common/config/app_config.dart';
import 'main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.setEnvironment(Environment.DEV);
  mainDelegate();
}

