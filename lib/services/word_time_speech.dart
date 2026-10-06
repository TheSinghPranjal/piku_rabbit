import 'package:flutter_tts/flutter_tts.dart';

import '../models/word_time.dart';

/// On-device speech for Word Time. Widget tests inject a fake.
abstract class WordTimeSpeaker {
  Future<void> speak(String text);

  Future<void> stop();
}

/// Speaks through the platform text-to-speech engine.
class FlutterTtsWordTimeSpeaker implements WordTimeSpeaker {
  FlutterTtsWordTimeSpeaker({
    FlutterTts? tts,
    this.speechRate = WordTimeLesson.speechRate,
  }) : _tts = tts ?? FlutterTts();

  final FlutterTts _tts;
  final double speechRate;
  var _configured = false;

  Future<void> _configure() async {
    if (_configured) return;
    await _tts.awaitSpeakCompletion(true);
    await _tts.setVolume(1);
    await _tts.setSpeechRate(speechRate);
    try {
      await _tts.setLanguage('en-US');
    } catch (_) {
      // Keep the device voice if English is unavailable.
    }
    _configured = true;
  }

  @override
  Future<void> speak(String text) async {
    try {
      await _configure();
      await _tts.speak(text);
    } catch (_) {
      // The lesson still advances if this device has no speech engine.
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {
      // Already silent, or this device has no speech engine.
    }
  }
}

/// Plays a word's letter-then-word script and can be stopped mid-utterance.
class WordTimeNarration {
  WordTimeNarration({
    required this.speaker,
    this.letterPause = WordTimeLesson.letterPause,
  });

  final WordTimeSpeaker speaker;
  final Duration letterPause;

  int _generation = 0;
  var _started = false;

  /// Drops the rest of the current word and silences the engine.
  Future<void> stop() async {
    _generation++;
    if (!_started) return;
    await speaker.stop();
  }

  /// Speaks [word] from the first letter. Stops anything already playing.
  Future<void> play(String word, void Function(int highlight) onCue) async {
    final generation = ++_generation;
    if (_started) {
      await speaker.stop();
      if (generation != _generation) return;
    }
    _started = true;

    final cues = WordTimeLesson.cuesFor(word);
    for (var i = 0; i < cues.length; i++) {
      if (generation != _generation) return;
      onCue(cues[i].highlight);
      await speaker.speak(cues[i].spoken);
      if (generation != _generation) return;
      if (i < cues.length - 1) {
        await Future<void>.delayed(letterPause);
      }
    }
  }
}
