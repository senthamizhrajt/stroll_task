import 'dart:io';
import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:stroll_task/common/utils/device_utils.dart';
import 'package:stroll_task/common/widgets/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

import '../../../common/widgets/base_stateful_widget.dart';
import '../../../common/widgets/user_picture.dart';

class StrollExploreScreen extends BaseStatefulWidget {
  final WeakReference<VideoPlayerController> weakReferenceVideoPlayerController;
  const StrollExploreScreen({required this.weakReferenceVideoPlayerController, super.key});

  @override
  State<StrollExploreScreen> createState() {
    return _StrollExploreScreenState();
  }
}

class _StrollExploreScreenState extends BaseWidgetState<StrollExploreScreen> with SingleTickerProviderStateMixin {
  late TransformationController viewTransformationController;

  final List<Offset> _positions = List.empty(growable: true);
  Size _size = Size.zero;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void onPause() {
    super.onPause();
    widget.weakReferenceVideoPlayerController.target?.pause();
  }

  @override
  void onRestart() {
    super.onRestart();
    widget.weakReferenceVideoPlayerController.target?.play();
  }

  @override
  void onResume() {
    super.onResume();
    widget.weakReferenceVideoPlayerController.target?.play();
  }

  @override
  void dispose() {
    widget.weakReferenceVideoPlayerController.target?.pause();
    //widget.videoPlayerController.seekTo(Duration(seconds: 2));
    //widget.videoPlayerController.dispose(); //TBH when to call the dispose method
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*final initialScale = calculateInitialScale(1280, 720, screenWidth, screenHeight);

    viewTransformationController = TransformationController();
    print(initialScale);

    viewTransformationController.value = Matrix4.identity()..scale(1.0);

    // Calculate the boundary margin dynamically based on the video size and screen size
    final videoWidth = 1280;
    final videoHeight = 720;
    final videoAspectRatio = videoWidth / videoHeight;

    double _boundaryMargin = 0.0;
    if (videoAspectRatio > screenAspectRatio) {
      _boundaryMargin = (screenWidth - (screenHeight / videoHeight * videoWidth)) / 2;
    } else {
      _boundaryMargin = (screenHeight - (screenWidth / videoWidth * videoHeight)) / 2;
    }

    print('boundar margin: $_boundaryMargin');*/

    return Scaffold(
      body: Stack(
        children: [
          InteractiveViewer(
            transformationController: viewTransformationController,
            constrained: false,
            minScale: 1,
            maxScale: 5,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: _size.width.isNaN ? MediaQuery.of(context).size.width : _size.width,
                    height: _size.height.isNaN ? MediaQuery.of(context).size.height : _size.height,
                    child: Stack(
                      children: [
                        _getVideoPlayer(),
                        Container(color: Colors.black12), //For visual representation. Not scoped
                        _getProfilesOverlay(),
                        const Center(
                            child: Text('Centered Video')) //This is just to give a visual representation for centering the video. Not scoped.
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const IntrinsicHeight(
            child: CustomAppBar(
              title: 'What is your artistic form of expression?',
              titleTextSize: 16,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  void _initialize() {
    final screenWidth = DeviceUtils.screenWidth;
    final screenHeight = DeviceUtils.screenHeight;

    Size size = calculateInitialScale(widget.weakReferenceVideoPlayerController.target?.value.size.width,
        widget.weakReferenceVideoPlayerController.target?.value.size.height, screenWidth, screenHeight);
    _size = size * 1.3;
    _generateRandomPositions(size.width, size.height);

    viewTransformationController = TransformationController();

    if (!_size.width.isNaN && !_size.height.isNaN) {
      viewTransformationController.value = Matrix4.identity()..translate(-((_size.width - screenWidth) / 2), -((_size.height - screenHeight) / 2));
    } else {
      _size = Size(DeviceUtils.screenWidth, DeviceUtils.screenHeight);
    }

    widget.weakReferenceVideoPlayerController.target?.addListener(() {
      //print('listening to vidoe: ${widget.weakReferenceVideoPlayerController.target?.value}');
    });

    //print(viewTransformationController.value);

    _listenForAudioInterrupts();

    //viewTransformationController.value = Matrix4.identity()..translate(10, 0);
    //viewTransformationController.value.translate(0, 0);
    widget.weakReferenceVideoPlayerController.target?.play();
  }

  Size calculateInitialScale(double? videoWidth, double? videoHeight, double screenWidth, double screenHeight) {
    if (videoWidth == null || videoHeight == null) return Size.zero;
    // Calculate aspect ratios
    final double videoAspectRatio = videoWidth / videoHeight;
    final double screenAspectRatio = screenWidth / screenHeight;

    // Calculate the scale based on aspect ratios
    if (videoAspectRatio > screenAspectRatio) {
      // Fit horizontally
      return Size(screenHeight * videoAspectRatio, screenHeight);
      //return screenHeight / videoHeight;
    } else {
      // Fit vertically
      return Size(screenWidth, screenWidth * videoAspectRatio);
      //return screenWidth / videoWidth;
    }
  }

  void _listenForAudioInterrupts() async {
    final session = await AudioSession.instance;
    session.setActive(true);

    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            // Another app started playing audio and we should duck.
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            // Another app started playing audio and we should pause.
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            // The interruption ended and we should unduck.
            break;
          case AudioInterruptionType.pause:
            widget.weakReferenceVideoPlayerController.target?.play();
          // The interruption ended and we should resume.
          case AudioInterruptionType.unknown:
            // The interruption ended but we should not resume.
            break;
        }
      }
    });
  }

  void _generateRandomPositions(double width, double height) {
    _positions.clear();
    // Number of widgets to be placed
    int numberOfWidgets = 20;
    // Size of the container (adjust as needed)
    double containerWidth = width;
    double containerHeight = height;
    // Minimum distance between widgets to avoid collision (adjust as needed)
    double minDistance = 96;

    for (int i = 0; i < numberOfWidgets; i++) {
      double x = Random().nextDouble() * (containerWidth - minDistance);
      double y = Random().nextDouble() * (containerHeight - minDistance);
      // Check for collision with existing widgets
      bool collides = _positions.any((pos) => (pos - Offset(x, y)).distance < minDistance);
      if (collides) {
        // Regenerate position if collision occurs
        i--;
      } else {
        _positions.add(Offset(x, y));
      }
    }
  }

  _getVideoPlayer() {
    return VideoPlayer(widget.weakReferenceVideoPlayerController.target!);
  }

  _getProfilesOverlay() {
    return Stack(
      children: _positions.map((pos) {
        return Positioned(
          left: pos.dx,
          top: pos.dy,
          child: const SizedBox(
            width: 96,
            height: 96,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 30,
                child: UserPicture.asset(name: 'Joey, 23', enableOverlay: true, radius: 27, path: 'assets/graphics/Image.png', borderWidth: 2),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
