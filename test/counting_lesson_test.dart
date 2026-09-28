import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/learn_topics.dart';
import 'package:piku_rabbit/models/rewards.dart';
import 'package:piku_rabbit/screens/learn/numbers_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('Next walks 1–4 through 12–16 and does not reward early', () {
    var progress = const CountingLessonProgress();
    expect(progress.showsNext, isTrue);
    expect(progress.shouldReward, isFalse);
    expect(progress.segment.label, '1 – 4');
    expect(progress.segment.asset, endsWith('piku-numbers-01-04.mp4'));
    expect(progress.poster, endsWith('piku-school-number-01.png'));

    const labels = ['4 – 8', '8 – 12', '12 – 16', '16 – 20'];
    for (var step = 0; step < labels.length; step++) {
      expect(progress.onClipFinished().shouldReward, isFalse);
      expect(progress.showsNext, isTrue);
      progress = progress.advance();
      expect(progress.segment.label, labels[step]);
      expect(progress.index, step + 1);
    }

    expect(progress.isFinale, isTrue);
    expect(progress.showsNext, isFalse);
    expect(progress.advance(), same(progress));
    expect(progress.shouldReward, isFalse);
    expect(progress.poster, endsWith('piku-school-number-16.png'));
  });

  test('the 16–20 clip rewards only after it finishes once', () {
    var progress = const CountingLessonProgress();
    while (progress.showsNext) {
      progress = progress.advance();
    }

    final finished = progress.onClipFinished();
    expect(finished.shouldReward, isTrue);
    expect(finished.showsNext, isFalse);
    expect(finished.poster, NumberVideos.finalePoster);
    expect(finished.onClipFinished(), same(finished));
    expect(
      LearnNumbersRules.rewardForComplete().message,
      'Amazing! You learned 1 to 20 with Piku!',
    );
  });

  test(
    'counting clips are bundled by stable filename and Bao numbers are gone',
    () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(NumberVideos.segments, hasLength(5));
      expect(
        NumberVideos.segments.map((segment) => segment.asset.split('/').last),
        [
          'piku-numbers-01-04.mp4',
          'piku-numbers-04-08.mp4',
          'piku-numbers-08-12.mp4',
          'piku-numbers-12-16.mp4',
          'piku-numbers-16-20.mp4',
        ],
      );

      for (final segment in NumberVideos.segments) {
        expect(File(segment.asset).existsSync(), isTrue, reason: segment.asset);
        expect(
          File(segment.poster).existsSync(),
          isTrue,
          reason: segment.poster,
        );
        expect(pubspec.contains('    - ${segment.asset}'), isTrue);
        expect(pubspec.contains('    - ${segment.poster}'), isTrue);
      }
      expect(File(NumberVideos.finalePoster).existsSync(), isTrue);
      expect(pubspec.contains('    - ${NumberVideos.finalePoster}'), isTrue);

      for (final gone in [
        'numbers_from_1to5.mp4',
        'numbers_from_6to10.mp4',
        'numbers_from_11to15.mp4',
        'numbers_from_16to20.mp4',
      ]) {
        expect(
          File('assets/videos/learn/numbers/$gone').existsSync(),
          isFalse,
          reason: gone,
        );
        expect(pubspec.contains(gone), isFalse, reason: gone);
      }

      expect(AlphabetVideos.segments, hasLength(7));
      expect(
        AlphabetVideos.segments.first,
        contains('Bao_speaking_alphabet_AtoD'),
      );
    },
  );

  testWidgets('Numbers starts on 1–4 with a Next control', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: NumbersScreen()));
    await tester.pump();

    expect(find.text('Numbers!'), findsOneWidget);
    expect(find.text('1 – 4'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump();

    expect(find.text('4 – 8'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
