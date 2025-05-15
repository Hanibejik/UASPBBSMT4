import 'package:just_audio/just_audio.dart';

class AudioController {
  static final AudioPlayer _player = AudioPlayer();
  static bool isMuted = false;

  static Future<void> init() async {
    try {
      await _player.setAsset('assets/audio/backsound.mp3');
      await _player.setLoopMode(LoopMode.one);
      await _player.setVolume(1.0);
      await _player.play();
    } catch (e) {
      print("❌ Gagal memutar audio: $e");
    }
  }

  static void mute() {
    isMuted = true;
    _player.setVolume(0.0);
  }

  static void unmute() {
    isMuted = false;
    _player.setVolume(1.0);
  }

  static bool getMutedStatus() => isMuted;

  static void dispose() {
    _player.dispose();
  }
}
