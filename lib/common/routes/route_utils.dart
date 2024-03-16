import 'package:flutter/material.dart';
import 'package:stroll_task/features/profile/model/explore_screen_arugments.dart';
import 'package:video_player/video_player.dart';

import '../../features/profile/ui/profile_voice_matching_screen.dart';
import '../../features/profile/ui/profile_onboarding_screen.dart';
import '../../features/profile/ui/stroll_explore_screen.dart';
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
        route = MaterialPageRoute(settings: settings, builder: (context) => const ProfileVoiceMatchingScreen());
        break;
      case Routes.profilesExploreScreen:
        ExploreScreenArguments arguments = settings.arguments as ExploreScreenArguments;
        route = MaterialPageRoute(
          settings: settings,
          builder: (context) => StrollExploreScreen(weakReferenceVideoPlayerController: arguments.controller),
        );
        break;
      default:
        route = MaterialPageRoute(settings: settings, builder: (context) => const UnknownRouteScreen());
        break;
    }

    return route;
  }
}
