import 'dev_config.dart';
import 'prod_config.dart';

enum Environment { DEV, STAGING, PROD }

class AppConfig {
  static String appName = DevConfig.APP_NAME;
  static bool isProduction = DevConfig.IS_PRODUCTION;

  static Future<void> setEnvironment(Environment env) async {
    switch (env) {
      case Environment.DEV:
        _copyFromDevConfig();
        break;
      case Environment.PROD:
        _copyFromProductionConfig();
        break;
      case Environment.STAGING:
        _copyFromDevConfig();
        break;
    }
  }

  static _copyFromDevConfig() {}

  static _copyFromProductionConfig() {
    appName = ProductionConfig.appName;
    isProduction = ProductionConfig.isProduction;
  }
}