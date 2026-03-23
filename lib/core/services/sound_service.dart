import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playTick() async {
    try {
      await _player.stop();
      await _player.setVolume(0.3);
      await _player.play(AssetSource('sounds/tick.mp3'));
    } catch (_) {}
  }

  static Future<void> playComplete() async {
    try {
      await _player.stop();
      await _player.setVolume(0.6);
      await _player.play(AssetSource('sounds/complete.mp3'));
    } catch (_) {}
  }
}
