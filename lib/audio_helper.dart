import 'package:flutter_soloud/flutter_soloud.dart';

class AudioHelper {
  late AudioSource _backgroundSource, _scoreSource;
  late SoLoud _soLoud;

  SoundHandle? _backgroundSoundHandle;

  Future<void> initialize() async {
    _soLoud = SoLoud.instance;

    if (await _soLoud.initialized) {
      return;
    }

    await _soLoud.init();

    _backgroundSource = await _soLoud.loadAsset(
      'assets/audio/background.mp3',
    );

    _scoreSource = await _soLoud.loadAsset(
      'assets/audio/score.mp3',
    );
  }

  void playBackgroundAudio() async {
    _backgroundSoundHandle = await _soLoud.play(_backgroundSource);
    _soLoud.setProtectVoice(_backgroundSoundHandle!, true);
  }

  void playSourceAudio() async {
    await _soLoud.play(_scoreSource);
  }

  void stopBackgroundAudio() {
    if (_backgroundSoundHandle == null) return;

    _soLoud.fadeVolume(
      _backgroundSoundHandle!,
      0.0,
      const Duration(
        milliseconds: 500,
      ),
    );
  }
}
