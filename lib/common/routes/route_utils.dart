import 'package:flutter/material.dart';

import '../../features/profile/ui/profile_voice_matching_screen.dart';
import '../../features/profile/ui/profile_onboarding_screen.dart';
import '../ui/unknown_route_screen.dart';
import 'routes.dart';

class RouteUtils {
  static PageRoute<dynamic>? onGenerateRoute(RouteSettings settings) {
    PageRoute? route;
    switch (settings.name) {
      case Routes.profileOnBoardingScreen:
        route = MaterialPageRoute(settings: settings, builder: (context) => const ProfileOnBoardingScreen());
        break;
      case Routes.profileVoiceMatchingScreen:
        route = MaterialPageRoute(settings: settings, builder: (context) => ProfileVoiceMatchingScreen());
        break;
      default:
        route = MaterialPageRoute(settings: settings, builder: (context) => const UnknownRouteScreen());
        break;
    }

    return route;
  }
}
