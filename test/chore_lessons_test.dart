import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/chore_lessons.dart';
import 'package:piku_rabbit/models/learn_topics.dart';
import 'package:piku_rabbit/models/morning_routine.dart';
import 'package:piku_rabbit/models/rewards.dart';
import 'package:piku_rabbit/screens/learn/chore_lesson_screens.dart';
import 'package:piku_rabbit/screens/learn/learn_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  void expectLesson({
    required List<RoutineStep> steps,
    required List<String> ids,
    required String firstLabel,
    required String lastId,
    required String lastLabel,
    required String finale,
    required String topicId,
    required String route,
  }) {
    expect(steps.map((step) => step.id), ids);
    expect(steps, hasLength(5));
    final pubspec = File('pubspec.yaml').readAsStringSync();
    for (final step in steps) {
      expect(step.idle.isVideo, isFalse, reason: '${step.id} idle');
      expect(step.action.isVideo, isFalse, reason: '${step.id} action');
      expect(step.idle.asset, endsWith('-before.jpg'));
      expect(step.action.asset, endsWith('-after.jpg'));
      expect(
        File(step.idle.asset).existsSync(),
        isTrue,
        reason: step.idle.asset,
      );
      expect(
        File(step.action.asset).existsSync(),
        isTrue,
        reason: step.action.asset,
      );
      expect(pubspec.contains('    - ${step.idle.asset}'), isTrue);
      expect(pubspec.contains('    - ${step.action.asset}'), isTrue);
    }

    var progress = RoutineLessonProgress(steps: steps);
    expect(progress.step.actionLabel, firstLabel);
    progress = progress.startAction().finishAction();
    expect(progress.showsNextAndReplay, isTrue);
    expect(progress.replay().phase, RoutinePhase.idle);
    while (!progress.isLast) {
      progress = progress.startAction().finishAction().next();
    }
    expect(progress.step.id, lastId);
    expect(progress.step.actionLabel, lastLabel);
    progress = progress.startAction().finishAction();
    expect(progress.showsNextAndReplay, isFalse);
    final done = progress.acknowledgeReward();
    expect(done.showsFinale, isTrue);
    expect(done.replay().phase, RoutinePhase.idle);
    expect(done.replay().step.id, lastId);

    final topic = LearnTopics.byId(topicId);
    expect(topic?.route, route);
    expect(
      File('lib/navigation/app_router.dart').readAsStringSync(),
      contains("path: '$route'"),
    );
    expect(finale, isNotEmpty);
  }

  test('Get Ready for Bed walks pajamas through lights off', () {
    expectLesson(
      steps: BedLesson.steps,
      ids: ['pajamas', 'brush-teeth', 'wash-face', 'get-in-bed', 'lights-off'],
      firstLabel: 'Pajamas',
      lastId: 'lights-off',
      lastLabel: 'Lights off',
      finale: BedLesson.rewardForComplete().message,
      topicId: 'get_ready_for_bed',
      route: '/learn/get-ready-for-bed',
    );
    expect(BedLesson.actionStillDuration, MorningRoutine.actionStillDuration);
    expect(
      BedLesson.rewardForComplete().stars,
      LearnNumbersRules.rewardForComplete().stars,
    );
    expect(
      BedLesson.rewardForComplete().message,
      'Amazing! Piku is ready for bed!',
    );
  });

  test('Clean Up Toys walks pick up through tidy room', () {
    expectLesson(
      steps: ToysLesson.steps,
      ids: ['pick-up', 'sort', 'put-in-boxes', 'shelf', 'tidy-room'],
      firstLabel: 'Pick up',
      lastId: 'tidy-room',
      lastLabel: 'Tidy up',
      finale: ToysLesson.rewardForComplete().message,
      topicId: 'clean_up_toys',
      route: '/learn/clean-up-toys',
    );
    expect(
      ToysLesson.rewardForComplete().message,
      'Amazing! Piku\'s toys are tidy!',
    );
  });

  test('Pack Lunch walks lunchbox through close pack', () {
    expectLesson(
      steps: LunchLesson.steps,
      ids: ['lunchbox', 'sandwich', 'fruit', 'water', 'close-pack'],
      firstLabel: 'Lunchbox',
      lastId: 'close-pack',
      lastLabel: 'Pack it',
      finale: LunchLesson.rewardForComplete().message,
      topicId: 'pack_lunch',
      route: '/learn/pack-lunch',
    );
    expect(
      LunchLesson.rewardForComplete().message,
      'Amazing! Piku\'s lunch is packed!',
    );
  });

  test('Feed a Pet walks bowl through clean up', () {
    expectLesson(
      steps: PetLesson.steps,
      ids: ['bowl', 'scoop', 'place', 'water', 'clean-up'],
      firstLabel: 'Bowl',
      lastId: 'clean-up',
      lastLabel: 'Clean up',
      finale: PetLesson.rewardForComplete().message,
      topicId: 'feed_a_pet',
      route: '/learn/feed-a-pet',
    );
    expect(PetLesson.rewardForComplete().message, 'Amazing! Piku fed the pet!');
  });

  testWidgets('each lesson opens on its first action', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final cases = <(Widget, String, String)>[
      (const GetReadyForBedScreen(), 'Get Ready for Bed!', 'Pajamas'),
      (const CleanUpToysScreen(), 'Clean Up Toys!', 'Pick up'),
      (const PackLunchScreen(), 'Pack Lunch!', 'Lunchbox'),
      (const FeedAPetScreen(), 'Feed a Pet!', 'Bowl'),
    ];
    for (final entry in cases) {
      await tester.pumpWidget(MaterialApp(home: entry.$1));
      await tester.pump();
      expect(find.text(entry.$2), findsOneWidget);
      expect(find.text(entry.$3), findsWidgets);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    }
  });

  testWidgets('School tray lists the four chore lessons', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: LearnScreen()));
    await tester.pump();

    expect(find.text('Morning Routine'), findsOneWidget);
    expect(find.text('Get Ready for Bed'), findsOneWidget);
    expect(find.text('Clean Up Toys'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chevron_right_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Pack Lunch'), findsOneWidget);
    expect(find.text('Feed a Pet'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
