import 'package:flutter/material.dart';

import '../../data/model/screen_arguments.dart';

class NavigationHandler {
  static final NavigationHandler _instance = NavigationHandler._init();

  factory NavigationHandler() => _instance;

  NavigationHandler._init();

  Future<T?> push<T extends Object?>(BuildContext context, String routeName, {ScreenArguments? arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  Future<T?> pushReplacement<T extends Object?>(BuildContext context, String routeName, {ScreenArguments? arguments}) {
    return Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  Future<T?> pushAndClearAll<T extends Object?>(BuildContext context, String routeName, {ScreenArguments? arguments}) {
    return Navigator.pushNamedAndRemoveUntil(context, routeName, (Route<dynamic> route) => false, arguments: arguments);
  }

  void popUntil<T extends Object?>(BuildContext context, String routeName, {ScreenArguments? arguments}) {
    return Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  Future<T?> replace<T extends Object?>(BuildContext context, String routeName, {ScreenArguments? arguments}) {
    return Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}
