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

    for (final step in GoToSchool.steps) {
      expect(step.idle.isVideo, isFalse, reason: step.id);
      expect(step.action.isVideo, isFalse, reason: step.id);
      expect(step.idle.asset, contains('-before.jpg'));
      expect(step.action.asset, contains('-after.jpg'));
    }
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
