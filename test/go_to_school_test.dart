import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/go_to_school.dart';
import 'package:piku_rabbit/models/learn_topics.dart';
import 'package:piku_rabbit/models/morning_routine.dart';
import 'package:piku_rabbit/models/rewards.dart';
import 'package:piku_rabbit/screens/learn/go_to_school_screen.dart';
import 'package:piku_rabbit/screens/learn/learn_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('steps run dress, tie, shoes, bag, then leave', () {
    expect(GoToSchool.steps.map((step) => step.id), [
      'dress',
      'tie',
      'shoes',
      'bag',
      'leave',
    ]);
    expect(GoToSchool.actionStillDuration, MorningRoutine.actionStillDuration);
    expect(GoToSchool.steps, hasLength(5));

    expect(GoToSchool.steps[0].idle.isVideo, isTrue);
    expect(GoToSchool.steps[0].action.isVideo, isTrue);
    expect(GoToSchool.steps[1].idle.isVideo, isTrue);
    expect(GoToSchool.steps[1].action.isVideo, isTrue);
    expect(GoToSchool.steps[2].idle.isVideo, isFalse);
    expect(
      GoToSchool.steps[2].idle.asset,
      endsWith('piku-school-03-shoes-before.jpg'),
    );
    expect(
      GoToSchool.steps[2].action.asset,
      endsWith('school-03-shoes-action.mp4'),
    );
    expect(GoToSchool.steps[3].idle.asset, endsWith('school-04-bag-idle.mp4'));
    expect(GoToSchool.steps[3].action.isVideo, isFalse);
    expect(
      GoToSchool.steps[3].action.asset,
      endsWith('piku-school-04-bag-after.jpg'),
    );
    expect(
      GoToSchool.steps[4].idle.asset,
      endsWith('school-05-leave-idle.mp4'),
    );
    expect(GoToSchool.steps[4].action.isVideo, isFalse);
    expect(
      GoToSchool.steps[4].action.asset,
      endsWith('piku-school-05-leave-after.jpg'),
    );

    final placeholders = [
      for (final step in GoToSchool.steps) ...[
        if (!step.idle.isVideo) step.idle.asset,
        if (!step.action.isVideo) step.action.asset,
      ],
    ];
    expect(placeholders, hasLength(3));
  });

  test('Next, Replay, and the finale match the morning routine', () {
    var progress = RoutineLessonProgress(steps: GoToSchool.steps);
    expect(progress.showsActionButton, isTrue);
    expect(progress.step.actionLabel, 'Dress');

    progress = progress.startAction().finishAction();
    expect(progress.showsNextAndReplay, isTrue);
    expect(progress.replay().phase, RoutinePhase.idle);
    progress = progress.next();
    expect(progress.step.actionLabel, 'Tie');

    while (!progress.isLast) {
      progress = progress.startAction().finishAction().next();
    }
    expect(progress.step.id, 'leave');
    expect(progress.step.actionLabel, "Let's go");
    progress = progress.startAction().finishAction();
    expect(progress.showsNextAndReplay, isFalse);
    final finale = progress.acknowledgeReward();
    expect(finale.showsFinale, isTrue);
    expect(finale.replay().index, 4);
    expect(finale.replay().phase, RoutinePhase.idle);

    expect(GoToSchoolRules.stars, LearnNumbersRules.rewardForComplete().stars);
    expect(
      GoToSchoolRules.rewardForComplete().message,
      'Amazing! Piku is ready for school!',
    );
  });

  test('school stills are bundled and the tray opens the lesson', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final clips = [
      for (final step in GoToSchool.steps) ...[step.idle, step.action],
    ];
    expect(clips, hasLength(10));
    for (final clip in clips) {
      expect(File(clip.asset).existsSync(), isTrue, reason: clip.asset);
      expect(
        pubspec.contains('    - ${clip.asset}'),
        isTrue,
        reason: clip.asset,
      );
    }
    final topic = LearnTopics.byId('go_to_school');
    expect(topic?.label, 'Go to School');
    expect(topic?.route, '/learn/go-to-school');
    expect(
      File('lib/navigation/app_router.dart').readAsStringSync(),
      contains("path: '/learn/go-to-school'"),
    );
  });

  testWidgets('Go to School starts on the dress step', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: GoToSchoolScreen()));
    await tester.pump();

    expect(find.text('Go to School!'), findsOneWidget);
    expect(find.text('School dress'), findsOneWidget);
    expect(find.text('Dress'), findsOneWidget);

    await tester.tap(find.text('Dress'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('School tray lists Go to School', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: LearnScreen()));
    await tester.pump();

    expect(find.text('Go to School'), findsOneWidget);
    expect(find.text('Morning Routine'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
