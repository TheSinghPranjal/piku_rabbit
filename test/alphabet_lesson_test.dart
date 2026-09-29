import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/learn_topics.dart';
import 'package:piku_rabbit/models/rewards.dart';
import 'package:piku_rabbit/screens/learn/alphabet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('Next walks A–B through X–Y and does not reward early', () {
    var progress = const AlphabetLessonProgress();
    expect(progress.showsNext, isTrue);
    expect(progress.shouldReward, isFalse);
    expect(progress.segment.label, 'A – B');
    expect(progress.segment.asset, endsWith('piku-alphabet-A-B.mp4'));

    for (var step = 0; step < AlphabetVideos.segments.length - 1; step++) {
      expect(progress.onClipFinished().shouldReward, isFalse);
      expect(progress.showsNext, isTrue);
      expect(progress.segment.label, AlphabetVideos.segments[step].label);
      progress = progress.advance();
      expect(progress.index, step + 1);
    }

    expect(progress.isFinale, isTrue);
    expect(progress.segment.label, 'Y – Z');
    expect(progress.showsNext, isFalse);
    expect(progress.advance(), same(progress));
    expect(progress.shouldReward, isFalse);
  });

  test('the Y–Z clip rewards only after it finishes once', () {
    var progress = const AlphabetLessonProgress();
    while (progress.showsNext) {
      progress = progress.advance();
    }

    final finished = progress.onClipFinished();
    expect(finished.shouldReward, isTrue);
    expect(finished.showsNext, isFalse);
    expect(finished.segment.asset, endsWith('piku-alphabet-Y-Z.mp4'));
    expect(finished.onClipFinished(), same(finished));
    expect(
      LearnAlphabetRules.rewardForComplete().message,
      'Amazing! You learned A to Z with Piku!',
    );
  });

  test(
    'alphabet clips are bundled in order and Bao alphabet videos are gone',
    () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      const names = [
        'piku-alphabet-A-B.mp4',
        'piku-alphabet-B-C.mp4',
        'piku-alphabet-C-D.mp4',
        'piku-alphabet-D-E.mp4',
        'piku-alphabet-E-F.mp4',
        'piku-alphabet-F-G.mp4',
        'piku-alphabet-G-H.mp4',
        'piku-alphabet-H-I.mp4',
        'piku-alphabet-I-J.mp4',
        'piku-alphabet-J-K.mp4',
        'piku-alphabet-K-L.mp4',
        'piku-alphabet-L-M.mp4',
        'piku-alphabet-M-N.mp4',
        'piku-alphabet-N-O.mp4',
        'piku-alphabet-O-P.mp4',
        'piku-alphabet-P-Q.mp4',
        'piku-alphabet-Q-R.mp4',
        'piku-alphabet-R-S.mp4',
        'piku-alphabet-S-T.mp4',
        'piku-alphabet-T-U.mp4',
        'piku-alphabet-U-V.mp4',
        'piku-alphabet-V-W.mp4',
        'piku-alphabet-W-X.mp4',
        'piku-alphabet-X-Y.mp4',
        'piku-alphabet-Y-Z.mp4',
      ];
      expect(AlphabetVideos.segments, hasLength(names.length));
      expect(
        AlphabetVideos.segments.map((segment) => segment.asset.split('/').last),
        names,
      );
      for (final segment in AlphabetVideos.segments) {
        expect(segment.asset, startsWith('assets/videos/learn/alphabets/'));
        expect(File(segment.asset).existsSync(), isTrue, reason: segment.asset);
        expect(pubspec.contains('    - ${segment.asset}'), isTrue);
      }
      for (final gone in [
        'Bao_speaking_alphabet_AtoD.mp4',
        'Bao_speaking_alphabet_EtoH.mp4',
        'Bao_speaking_alphabet_ItoL.mp4',
        'Bao_speaking_alphabet_MtoP.mp4',
        'Bao_speaking_alphabet_QtoT.mp4',
        'Bao_speaking_alphabet_UtoX.mp4',
        'Bao_speaking_alphabet_YtoZ.mp4',
      ]) {
        expect(
          File('assets/videos/learn/alphabets/$gone').existsSync(),
          isFalse,
          reason: gone,
        );
        expect(pubspec.contains(gone), isFalse, reason: gone);
      }
    },
  );

  testWidgets('Alphabet starts on A–B with a Next control', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: AlphabetScreen()));
    await tester.pump();

    expect(find.text('Alphabet!'), findsOneWidget);
    expect(find.text('A – B'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump();

    expect(find.text('B – C'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
