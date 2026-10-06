import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/learn_topics.dart';
import 'package:piku_rabbit/models/morning_routine.dart';
import 'package:piku_rabbit/models/rewards.dart';
import 'package:piku_rabbit/screens/learn/learn_screen.dart';
import 'package:piku_rabbit/screens/learn/morning_routine_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('steps stay in order and six clips are still images', () {
    const ids = [
      'waking',
      'brushing',
      'flossing',
      'hands',
      'face',
      'hairwash',
      'scrub',
      'soap',
      'bathing',
      'towel',
      'dressed',
      'hairdry',
    ];
    expect(MorningRoutine.steps.map((step) => step.id), ids);
    expect(
      MorningRoutine.actionStillDuration,
      const Duration(milliseconds: 2500),
    );

    final placeholders = [
      for (final step in MorningRoutine.steps) ...[
        if (!step.idle.isVideo) step.idle.asset,
        if (!step.action.isVideo) step.action.asset,
      ],
    ];
    expect(placeholders, [
      'assets/images/routine/piku-routine-02-brushing-after.jpg',
      'assets/images/routine/piku-routine-08-soap-after.jpg',
      'assets/images/routine/piku-routine-09-bathing-after.jpg',
      'assets/images/routine/piku-routine-10-towel-after.jpg',
      'assets/images/routine/piku-routine-11-dressed-before.jpg',
      'assets/images/routine/piku-routine-12-hairdry-after.jpg',
    ]);

    expect(
      MorningRoutine.steps.first.idle.asset,
      'assets/videos/routine/piku-routine-01-waking-idle.mp4',
    );
    expect(MorningRoutine.steps.first.action.isVideo, isTrue);
    expect(MorningRoutine.steps[2].id, 'flossing');
    expect(MorningRoutine.steps[2].idle.isVideo, isTrue);
    expect(MorningRoutine.steps[2].action.isVideo, isTrue);
    expect(
      MorningRoutine.steps[2].idle.asset,
      'assets/videos/routine/piku-routine-03-flossing-idle.mp4',
    );
    expect(
      MorningRoutine.steps[2].action.asset,
      'assets/videos/routine/piku-routine-03-flossing-action.mp4',
    );
    expect(MorningRoutine.steps[3].id, 'hands');
    expect(MorningRoutine.steps[3].idle.isVideo, isTrue);
    expect(MorningRoutine.steps[3].action.isVideo, isTrue);
    expect(
      MorningRoutine.steps[3].idle.asset,
      'assets/videos/routine/piku-routine-04-hands-idle.mp4',
    );
    expect(
      MorningRoutine.steps[3].action.asset,
      'assets/videos/routine/piku-routine-04-hands-action.mp4',
    );
    expect(MorningRoutine.steps[10].idle.isVideo, isFalse);
    expect(MorningRoutine.steps[10].action.isVideo, isTrue);
  });

  test('action, next, replay, and the finale follow the numbers reward', () {
    var progress = const RoutineLessonProgress();
    expect(progress.showsActionButton, isTrue);
    expect(progress.startAction(), isNot(same(progress)));
    expect(progress.finishAction(), same(progress));

    progress = progress.startAction().finishAction();
    expect(progress.phase, RoutinePhase.rewarded);
    expect(progress.showsNextAndReplay, isTrue);
    expect(progress.acknowledgeReward(), same(progress));
    expect(progress.replay().phase, RoutinePhase.idle);
    expect(progress.replay().index, 0);

    progress = progress.next();
    expect(progress.index, 1);
    expect(progress.phase, RoutinePhase.idle);
    expect(progress.step.actionLabel, 'Brush');

    while (!progress.isLast) {
      progress = progress.startAction().finishAction().next();
    }
    expect(progress.step.id, 'hairdry');
    expect(progress.showsActionButton, isTrue);
    progress = progress.startAction().finishAction();
    expect(progress.showsNextAndReplay, isFalse);
    expect(progress.next(), same(progress));
    final finale = progress.acknowledgeReward();
    expect(finale.showsFinale, isTrue);
    expect(finale.replay().phase, RoutinePhase.idle);
    expect(finale.replay().index, 11);

    expect(
      MorningRoutineRules.stars,
      LearnNumbersRules.rewardForComplete().stars,
    );
    expect(
      MorningRoutineRules.magicBeans,
      LearnNumbersRules.rewardForComplete().magicBeans,
    );
    expect(
      MorningRoutineRules.rewardForComplete().message,
      'Amazing! Piku finished the morning routine!',
    );
  });

  test('routine assets are bundled and the School tray opens the lesson', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final clips = [
      for (final step in MorningRoutine.steps) ...[step.idle, step.action],
    ];
    expect(clips, hasLength(24));
    for (final clip in clips) {
      expect(File(clip.asset).existsSync(), isTrue, reason: clip.asset);
      expect(
        pubspec.contains('    - ${clip.asset}'),
        isTrue,
        reason: clip.asset,
      );
    }
    final topic = LearnTopics.byId('morning_routine');
    expect(topic, isNotNull);
    expect(topic!.label, 'Morning Routine');
    expect(topic.route, '/learn/morning-routine');
    expect(
      File('lib/navigation/app_router.dart').readAsStringSync(),
      contains("path: '/learn/morning-routine'"),
    );
  });

  testWidgets('Morning Routine starts on Wake up', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: MorningRoutineScreen()));
    await tester.pump();

    expect(find.text('Morning Routine!'), findsOneWidget);
    expect(find.text('Waking up'), findsOneWidget);
    expect(find.text('Wake up'), findsOneWidget);

    await tester.tap(find.text('Wake up'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump();

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('School tray lists Morning Routine with the other lessons', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: LearnScreen()));
    await tester.pump();

    expect(find.text('Alphabet'), findsOneWidget);
    expect(find.text('Numbers'), findsOneWidget);
    expect(find.text('Morning Routine'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
