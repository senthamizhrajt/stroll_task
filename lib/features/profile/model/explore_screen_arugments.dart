import 'package:video_player/video_player.dart';

import '../../../data/model/screen_arguments.dart';

class ExploreScreenArguments extends ScreenArguments {
  final WeakReference<VideoPlayerController> controller;

  ExploreScreenArguments(this.controller);
}