import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:focuspulse/core/services/storage_service.dart';

enum AmbientSound {
  none(label: 'None', asset: ''),
  rain(label: 'Rain', asset: 'sounds/rain.mp3'),
  forest(label: 'Forest', asset: 'sounds/forest.mp3'),
  zen(label: 'Zen', asset: 'sounds/zen.mp3'),
  waves(label: 'Waves', asset: 'sounds/waves.mp3');

  const AmbientSound({required this.label, required this.asset});
  final String label;
  final String asset;
}

class AudioController extends ChangeNotifier {
  final AudioPlayer _bgPlayer = AudioPlayer();
  AmbientSound _selectedSound = AmbientSound.none;
  bool _isMuted = false;
  bool _isPlaying = false;
  bool _isTicksEnabled = true;

  AmbientSound get selectedSound => _selectedSound;
  bool get isMuted => _isMuted;
  bool get isPlaying => _isPlaying;
  bool get isTicksEnabled => _isTicksEnabled;

  AudioController() {
    _bgPlayer.setReleaseMode(ReleaseMode.loop);
    _loadSettings();
  }

  void reload() {
    _loadSettings();
  }

  void _loadSettings() {
    final muted = StorageService.getString('audio_muted');
    if (muted != null) _isMuted = muted == 'true';
    
    final ticks = StorageService.getString('ticks_enabled');
    if (ticks != null) _isTicksEnabled = ticks == 'true';
    else _isTicksEnabled = false; // Default to OFF because it's annoying with music

    final soundName = StorageService.getString('selected_ambient_sound');
    if (soundName != null) {
      _selectedSound = AmbientSound.values.firstWhere(
        (e) => e.name == soundName,
        orElse: () => AmbientSound.none,
      );
    } else {
      _selectedSound = AmbientSound.rain;
    }
    notifyListeners();
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    await StorageService.setString('audio_muted', _isMuted.toString());
    if (_isMuted) {
      await _bgPlayer.setVolume(0);
    } else {
      await _bgPlayer.setVolume(0.5);
    }
    notifyListeners();
  }

  Future<void> toggleTicks() async {
    _isTicksEnabled = !_isTicksEnabled;
    await StorageService.setString('ticks_enabled', _isTicksEnabled.toString());
    notifyListeners();
  }

  Future<void> setSound(AmbientSound sound) async {
    _selectedSound = sound;
    await StorageService.setString('selected_ambient_sound', sound.name);
    
    if (_isPlaying) {
      await play();
    }
    notifyListeners();
  }

  Future<void> play() async {
    if (_selectedSound == AmbientSound.none) {
      await stop();
      return;
    }

    try {
      debugPrint("AudioController: Playing sound ${_selectedSound.asset}");
      await _bgPlayer.stop();
      await _bgPlayer.setVolume(_isMuted ? 0 : 0.5);
      await _bgPlayer.play(AssetSource(_selectedSound.asset));
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      debugPrint("AudioController Error: $e");
      _isPlaying = false;
    }
  }

  Future<void> pause() async {
    await _bgPlayer.pause();
    notifyListeners();
  }

  Future<void> stop() async {
    await _bgPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _bgPlayer.dispose();
    super.dispose();
  }
}
