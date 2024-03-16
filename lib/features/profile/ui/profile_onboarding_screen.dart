import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroll_task/common/widgets/user_picture.dart';
import 'package:stroll_task/features/profile/model/explore_screen_arugments.dart';
import 'package:video_player/video_player.dart';

import '../../../common/routes/routes.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/base_stateful_widget.dart';
import '../../../common/widgets/text_image.dart';
import '../../../core/navigation/navigation_handler.dart';
import 'custom/answer_toggle_buttons.dart';
import '../../../core/l10n/strings.dart';
import '../../../core/theme/app_colors.dart';
import 'custom/bottom_menu_bar.dart';

class ProfileOnBoardingScreen extends BaseStatefulWidget {
  const ProfileOnBoardingScreen({super.key});

  @override
  State<BaseStatefulWidget> createState() {
    return _ProfileOnBoardingScreenState();
  }
}

class _ProfileOnBoardingScreenState extends BaseWidgetState<ProfileOnBoardingScreen> {
  late WeakReference<VideoPlayerController> _videoController;

  @override
  void initState() {
    super.initState();
    _prepareVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.target?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(
        height: kToolbarHeight,
        padding: EdgeInsets.zero,
        child: BottomMenuBar(),
      ),
      body: Stack(
        children: [
          FractionallySizedBox(
            heightFactor: 0.75,
            widthFactor: 1,
            child: Image.asset(
              'assets/graphics/sunset.jpeg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Stack(
            children: [
              _getTopChildWidget(),
              _getBottomChildWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getTopChildWidget() {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextImage(
            mainAxisAlignment: MainAxisAlignment.center,
            text: Strings.screenTitle.translate(context),
            reverse: true,
            style: const TextStyle(
              fontSize: 34,
              color: Color(0xFFCCC8FF),
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black38,
                  offset: Offset(1, 1),
                  blurRadius: 4,
                ),
              ],
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_sharp,
              color: AppColors.accentColorLight,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextImage(
                mainAxisAlignment: MainAxisAlignment.center,
                text: '22h 00m',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                assetPath: 'assets/icons/timer.svg',
                imageHeight: 13,
              ),
              SizedBox(width: 12),
              TextImage(
                mainAxisAlignment: MainAxisAlignment.center,
                text: '103',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                assetPath: 'assets/icons/user.svg',
                imageHeight: 13,
                imageColor: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _getBottomChildWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(top: 220),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Color(0xFF0F1115),
              Color(0xFF0D0E12),
              Color(0xFF0B0C0F),
              Color(0xFF090B0D),
              Colors.black,
            ],
            stops: [0.0, 0.5, 0.6, 0.7, 0.8, 0.9],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 28),
                    const Opacity(
                      opacity: 0,
                      child: CircleAvatar(radius: 30),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: const Offset(-42, 0),
                              child: Container(
                                padding: const EdgeInsets.only(left: 48, top: 2, bottom: 2, right: 8),
                                decoration: BoxDecoration(color: const Color(0xFF121517), borderRadius: BorderRadius.circular(100)),
                                child: Text(
                                  Strings.username.translate(context),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 12, right: 24),
                              child: Text(
                                Strings.question1.translate(context),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: UserPicture.asset(path: 'assets/graphics/Image.png'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                Strings.userAnswer.translate(context),
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.accentColorLight),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AnswerToggleButtons(
                optionsList: [
                  Strings.option1.translate(context),
                  Strings.option2.translate(context),
                  Strings.option3.translate(context),
                  Strings.option4.translate(context),
                ],
                selectedColor: AppColors.accentColor,
                onToggle: (int value) {
                  //save the answer here
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.questionInfoText.translate(context),
                    style: const TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigationHandler().push(context, Routes.profileVoiceMatchingScreen);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/voice.svg',
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          if (_videoController.target == null || !_videoController.target!.value.isInitialized) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Attention'),
                                    content: const Text('Video is loaded yet. Please wait for the video to be loaded and try again.'),
                                    actions: [
                                      AppButton.accent(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        text: 'Close',
                                      )
                                    ],
                                  );
                                });
                            return;
                          }
                          NavigationHandler().push(context, Routes.profilesExploreScreen, arguments: ExploreScreenArguments(_videoController));
                        },
                        child: SvgPicture.asset(
                          'assets/icons/right_arrow.svg',
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _prepareVideoPlayer() async {
    _videoController = WeakReference(VideoPlayerController.asset(
      //Uri.parse('https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
      'assets/videos/background_video.mp4',
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true, mixWithOthers: true),
    ));

    _videoController.target?.setLooping(true);
    _videoController.target?.initialize().then((_) {
      _videoController.target?.seekTo(const Duration(seconds: 2));
    });
  }
}
