import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/date_time_utils.dart';
import '../../../common/widgets/asset_icon.dart';
import '../../../common/widgets/base_stateful_widget.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/user_picture.dart';
import '../../../core/l10n/strings.dart';
import '../../../core/theme/app_colors.dart';
import '../provider/voice_record_state_provider.dart';
import 'painters/wave_form_painter.dart';

class ProfileVoiceMatchingScreen extends BaseStatefulWidget {
  const ProfileVoiceMatchingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileVoiceMatchingScreenState();
  }
}

class _ProfileVoiceMatchingScreenState extends BaseWidgetState {
  late VoiceRecordStateProvider _voiceRecordStateProvider;

  @override
  void dispose() {
    _voiceRecordStateProvider.cleanUp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _voiceRecordStateProvider = VoiceRecordStateProvider();
    return ChangeNotifierProvider<VoiceRecordStateProvider>(
      create: (_) => _voiceRecordStateProvider,
      child: Scaffold(
        body: Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 0.75,
              child: Image.asset(
                'assets/graphics/joey.jpeg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            _getBottomWidget(context),
            _getAppBar(context),
          ],
        ),
      ),
    );
  }

  Widget _getBottomWidget(final BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 220),
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
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserPicture.asset(path: 'assets/graphics/Image.png', radius: 20, borderWidth: 3),
            Transform.translate(
              offset: const Offset(0, -6),
              child: Container(
                padding: const EdgeInsets.only(left: 12, top: 2, bottom: 2, right: 12),
                decoration: BoxDecoration(color: const Color(0xFF121517), borderRadius: BorderRadius.circular(100)),
                child: Text(
                  Strings.strollQuestion.translate(context),
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ),
            Text(
              Strings.question1.translate(context),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                Strings.userAnswer.translate(context),
                style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.accentColorLight),
              ),
            ),
            Consumer<VoiceRecordStateProvider>(
              builder: (context, provider, child) {
                String fileName = provider.state == RecorderState.recording
                    ? 'stop'
                    : provider.state == RecorderState.stopped || provider.state == RecorderState.paused || provider.state == RecorderState.completed
                        ? 'play'
                        : provider.state == RecorderState.playing
                            ? 'pause'
                            : 'record';

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            color: provider.state == RecorderState.none
                                ? Theme.of(context).secondaryHeaderColor.withOpacity(0.3)
                                : provider.state == RecorderState.recording
                                    ? AppColors.accentColor
                                    : Theme.of(context).textTheme.labelSmall?.color,
                          ),
                          children: [
                            if (provider.state == RecorderState.playing ||
                                provider.state == RecorderState.stopped ||
                                provider.state == RecorderState.paused ||
                                provider.state == RecorderState.completed)
                              TextSpan(text: DateTimeUtils.formatDuration(provider.playingDurationInSeconds)),
                            if (provider.state == RecorderState.playing ||
                                provider.state == RecorderState.stopped ||
                                provider.state == RecorderState.paused ||
                                provider.state == RecorderState.completed)
                              const TextSpan(text: ' / '),
                            TextSpan(text: DateTimeUtils.formatDuration(provider.recordingDurationInSeconds)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 16),
                      child: Container(
                        height: 55,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              child: CustomPaint(
                                size: Size(MediaQuery.of(context).size.width - 32, 55.0),
                                painter: WaveformPainter(provider.amplitudeList, 40, Theme.of(context).secondaryHeaderColor.withOpacity(0.3)),
                              ),
                            ),
                            //Container(height: 1, color: Colors.transparent),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            Strings.delete.translate(context),
                            style: TextStyle(
                                fontSize: 13,
                                color: provider.state == RecorderState.none || provider.state == RecorderState.recording
                                    ? Theme.of(context).secondaryHeaderColor.withOpacity(0.3)
                                    : null),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (provider.state == RecorderState.none) {
                                _voiceRecordStateProvider.startRecording();
                              } else if (provider.state == RecorderState.recording) {
                                _voiceRecordStateProvider.stopRecording();
                              } else if (provider.state == RecorderState.stopped ||
                                  provider.state == RecorderState.paused ||
                                  provider.state == RecorderState.completed) {
                                _voiceRecordStateProvider.playCurrentRecording();
                              } else if (provider.state == RecorderState.playing) {
                                _voiceRecordStateProvider.pauseCurrentRecording();
                              }
                            },
                            child: AssetIcon.svg(path: 'assets/icons/$fileName.svg', height: 64),
                          ),
                          Text(
                            Strings.submit.translate(context),
                            style: TextStyle(
                                fontSize: 13,
                                color: provider.state == RecorderState.none || provider.state == RecorderState.recording
                                    ? Theme.of(context).secondaryHeaderColor.withOpacity(0.3)
                                    : null),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      Strings.unMatch.translate(context),
                      style: TextStyle(
                          fontSize: 13,
                          color: provider.state == RecorderState.recording ? AppColors.negativeColor.withOpacity(0.5) : AppColors.negativeColor),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _getAppBar(final BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: IntrinsicHeight(
            child: CustomAppBar(
              title: Strings.username.translate(context),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16),
          child: Row(
            children: [
              Expanded(child: _getPageIndicator(true)),
              const SizedBox(width: 12),
              Expanded(child: _getPageIndicator(false)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getPageIndicator(bool isActive) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2000),
        color: isActive ? Colors.white : Colors.white24,
      ),
    );
  }
}
