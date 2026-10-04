import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/learn_topics.dart';
import 'package:piku_rabbit/models/word_time.dart';
import 'package:piku_rabbit/screens/learn/word_time_screen.dart';
import 'package:piku_rabbit/services/word_time_speech.dart';

void main() {
  const words = [
    'CAT',
    'DOG',
    'MAT',
    'BAT',
    'RAT',
    'HAT',
    'SUN',
    'CUP',
    'BUS',
    'PEN',
  ];

  test('lesson is the ten words in order, with their letters', () {
    expect(WordTimeLesson.words.map((word) => word.word).toList(), words);
    expect(WordTimeLesson.speechRate, 0.4);
    expect(WordTimeLesson.letterPause, const Duration(milliseconds: 400));

    for (final word in WordTimeLesson.words) {
      expect(word.letters, word.word.split(''));
      expect(word.letters, hasLength(3));
      final cues = WordTimeLesson.cuesFor(word.word);
      expect(cues.map((cue) => cue.spoken).toList(), [
        ...word.letters,
        '${word.word}!',
      ]);
      expect(cues.map((cue) => cue.highlight).toList(), [
        0,
        1,
        2,
        WordTimeLesson.wholeWord,
      ]);
    }
  });

  test('Next walks CAT through PEN', () {
    var progress = const WordTimeProgress();
    expect(progress.label, '1/10');
    expect(progress.word.word, 'CAT');
    expect(progress.isLast, isFalse);

    for (var i = 1; i < WordTimeLesson.words.length; i++) {
      progress = progress.advance();
      expect(progress.index, i);
      expect(progress.word.word, words[i]);
      expect(progress.label, '${i + 1}/10');
    }

    expect(progress.isLast, isTrue);
    expect(progress.word.word, 'PEN');
    expect(progress.advance(), same(progress));
  });

  test('word stills are bundled and the School tray opens the lesson', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(WordTimeLesson.words, hasLength(10));
    for (final word in WordTimeLesson.words) {
      expect(
        word.asset,
        'assets/images/word-lesson/piku-word-${word.word.toLowerCase()}.jpg',
      );
      expect(File(word.asset).existsSync(), isTrue, reason: word.asset);
      expect(
        pubspec.contains('    - ${word.asset}'),
        isTrue,
        reason: word.asset,
      );
    }

    final topic = LearnTopics.byId('word_time');
    expect(topic?.label, 'Word Time');
    expect(topic?.route, '/learn/word-time');
    expect(topic?.hasActivity, isTrue);
    expect(
      File('lib/navigation/app_router.dart').readAsStringSync(),
      contains("path: '/learn/word-time'"),
    );
  });

  test('narration speaks each letter, pauses, then the word', () async {
    final speaker = FakeWordTimeSpeaker();
    final narration = WordTimeNarration(
      speaker: speaker,
      letterPause: Duration.zero,
    );
    final highlights = <int>[];

    await narration.play('CAT', highlights.add);

    expect(speaker.spoken, ['C', 'A', 'T', 'CAT!']);
    expect(highlights, [0, 1, 2, WordTimeLesson.wholeWord]);
    expect(speaker.stopCount, 0);
  });

  test('stop drops the rest of the current word', () async {
    final speaker = FakeWordTimeSpeaker(autoComplete: false);
    final narration = WordTimeNarration(speaker: speaker);
    final future = narration.play('CAT', (_) {});
    await Future<void>.delayed(Duration.zero);

    expect(speaker.spoken, ['C']);
    await narration.stop();
    await future;

    expect(speaker.spoken, ['C']);
    expect(speaker.stopCount, 1);
  });

  testWidgets('Replay repeats the current word and Next moves on', (
    tester,
  ) async {
    final speaker = FakeWordTimeSpeaker(autoComplete: false);
    await tester.pumpWidget(
      MaterialApp(home: WordTimeScreen(speaker: speaker)),
    );

    expect(find.text('1/10'), findsOneWidget);
    expect(find.text('Replay'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.pump();
    await tester.pump();

    expect(speaker.spoken, ['C']);
    expect(find.byKey(const ValueKey('word-letter-0-lit')), findsOneWidget);
    expect(find.byKey(const ValueKey('word-letter-1-dim')), findsOneWidget);
    expect(find.byKey(const ValueKey('word-letter-2-dim')), findsOneWidget);

    await tester.tap(find.text('Replay'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump();

    expect(speaker.spoken, ['C', 'C']);
    expect(speaker.stopCount, 1);
    expect(find.text('1/10'), findsOneWidget);
    expect(find.text('DOG'), findsNothing);
    expect(find.byKey(const ValueKey('word-letter-0-lit')), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump();

    expect(find.text('2/10'), findsOneWidget);
    expect(find.text('D'), findsOneWidget);
    expect(find.text('C'), findsNothing);
    expect(speaker.spoken, ['C', 'C', 'D']);
    expect(speaker.stopCount, 2);
    expect(find.byKey(const ValueKey('word-letter-0-lit')), findsOneWidget);
    expect(find.byKey(const ValueKey('word-letter-1-dim')), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('Next on the last word stops speech and returns', (tester) async {
    final speaker = FakeWordTimeSpeaker(autoComplete: false);
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<bool>(
                  builder: (_) => WordTimeScreen(
                    speaker: speaker,
                    initialIndex: WordTimeLesson.words.length - 1,
                  ),
                ),
              );
            },
            child: const Text('School tray'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('School tray'));
    await tester.pumpAndSettle();

    expect(find.text('10/10'), findsOneWidget);
    expect(find.text('P'), findsOneWidget);
    expect(speaker.spoken, ['P']);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('10/10'), findsNothing);
    expect(find.text('School tray'), findsOneWidget);
    expect(speaker.spoken, ['P']);
    expect(speaker.stopCount, greaterThan(0));
  });
}

/// Records utterances. When [autoComplete] is false, [speak] waits until [stop].
class FakeWordTimeSpeaker implements WordTimeSpeaker {
  FakeWordTimeSpeaker({this.autoComplete = true});

  final bool autoComplete;
  final spoken = <String>[];
  int stopCount = 0;
  final List<Completer<void>> _pending = [];

  @override
  Future<void> speak(String text) {
    spoken.add(text);
    if (autoComplete) return Future<void>.value();
    final completer = Completer<void>();
    _pending.add(completer);
    return completer.future;
  }

  @override
  Future<void> stop() async {
    stopCount++;
    for (final completer in _pending) {
      if (!completer.isCompleted) completer.complete();
    }
    _pending.clear();
  }
}
