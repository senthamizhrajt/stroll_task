import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

enum RecorderState { none, recording, stopped, playing, paused, completed }

class VoiceRecordStateProvider with ChangeNotifier {
  RecorderState state = RecorderState.none;
  int recordingDurationInSeconds = 0, playingDurationInSeconds = 0, _recordingDurationInMilliSeconds = 0;
  String? filePath = 'recording';
  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Amplitude>? _amplitudeSub;
  final List<double> amplitudeList = List.empty(growable: true);
  Timer? _recordTimer, _playTimer;
  int currentAmplitudeIndex = -1;
  final AudioPlayer _player = AudioPlayer();

  void startRecording() async {
    if (await _recorder.hasPermission()) {
      // Start recording to file
      final dir = await getApplicationDocumentsDirectory();
      String fil = path.join(
        dir.path,
        'audio_${DateTime.now().millisecondsSinceEpoch}.wav',
      );
      amplitudeList.clear();

      await _recorder.start(const RecordConfig(encoder: AudioEncoder.wav, noiseSuppress: true), path: fil);
      _startRecordTimer();

      _amplitudeSub = _recorder.onAmplitudeChanged(const Duration(milliseconds: 200)).listen((amp) {
        amplitudeList.add(amp.current.abs() > 45 ? 45 : amp.current.abs());
      });

      state = RecorderState.recording;
      notifyListeners();
    }
  }

  void stopRecording() async {
    String? path = await _recorder.stop();
    state = RecorderState.stopped;
    _recordTimer?.cancel();
    filePath = path;
    notifyListeners();
  }

  void playCurrentRecording() async {
    state = RecorderState.playing;
    _player.onDurationChanged.listen((updatedDuration) {
      //notifyListeners();
    });
    _player.onPositionChanged.listen((newPosition) {
      playingDurationInSeconds = newPosition.inSeconds;
      notifyListeners();
    });

    await _player.play(DeviceFileSource(filePath!),
        position: _player.state == PlayerState.paused ? await _player.getCurrentPosition() : Duration.zero);
    _startPlayTimer();

    _player.onPlayerComplete.listen((event) {
      pauseCurrentRecording();
      currentAmplitudeIndex = -1;
      state = RecorderState.completed;
    });
    notifyListeners();
  }

  void pauseCurrentRecording() {
    _player.pause();
    state = RecorderState.paused;
    _recordTimer?.cancel();
    _playTimer?.cancel();
    notifyListeners();
  }

  void _startRecordTimer() {
    _recordTimer?.cancel();

    _recordTimer = Timer.periodic(const Duration(milliseconds: 200), (Timer t) {
      _recordingDurationInMilliSeconds = _recordingDurationInMilliSeconds + 200;
      recordingDurationInSeconds = (_recordingDurationInMilliSeconds / 1000).floor();
      notifyListeners();
    });
  }

  void _startPlayTimer() {
    _playTimer?.cancel();

    _playTimer = Timer.periodic(const Duration(milliseconds: 200), (Timer t) {
      currentAmplitudeIndex++;
      notifyListeners();
    });
  }

  void cleanUp() {
    _recordTimer?.cancel();
    _playTimer?.cancel();
    _recorder.stop();
    _recorder.dispose();
    _player.stop();
    _player.dispose();
  }
}
