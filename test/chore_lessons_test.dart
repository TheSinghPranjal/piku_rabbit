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
      for (final clip in [step.idle, step.action]) {
        expect(File(clip.asset).existsSync(), isTrue, reason: clip.asset);
        expect(pubspec.contains('    - ${clip.asset}'), isTrue);
        if (clip.isVideo) {
          expect(clip.asset, endsWith('.mp4'), reason: step.id);
        } else {
          expect(
            clip.asset.endsWith('-before.jpg') ||
                clip.asset.endsWith('-after.jpg'),
            isTrue,
            reason: clip.asset,
          );
        }
      }
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

  test('only the delivered clips are videos', () {
    String path(RoutineClip clip) => clip.asset;
    expect(
      {
        for (final step in BedLesson.steps)
          if (step.idle.isVideo || step.action.isVideo)
            step.id: (
              path(step.idle),
              path(step.action),
              step.idle.isVideo,
              step.action.isVideo,
            ),
      },
      {
        'get-in-bed': (
          'assets/videos/bed-routine/bed-04-get-in-bed-idle.mp4',
          'assets/videos/bed-routine/bed-04-get-in-bed-action.mp4',
          true,
          true,
        ),
      },
    );
    expect(
      [
        for (final step in ToysLesson.steps)
          (step.id, step.idle.isVideo, step.action.isVideo, path(step.idle)),
      ],
      [
        (
          'pick-up',
          true,
          false,
          'assets/videos/toys-routine/toys-01-pick-up-idle.mp4',
        ),
        (
          'sort',
          true,
          false,
          'assets/videos/toys-routine/toys-02-sort-idle.mp4',
        ),
        (
          'put-in-boxes',
          true,
          false,
          'assets/videos/toys-routine/toys-03-put-in-boxes-idle.mp4',
        ),
        (
          'shelf',
          true,
          false,
          'assets/videos/toys-routine/toys-04-shelf-idle.mp4',
        ),
        (
          'tidy-room',
          true,
          false,
          'assets/videos/toys-routine/toys-05-tidy-room-idle.mp4',
        ),
      ],
    );
    expect(
      [
        for (final step in LunchLesson.steps)
          if (step.idle.isVideo || step.action.isVideo)
            (step.id, step.idle.isVideo, step.action.isVideo, path(step.idle)),
      ],
      [
        (
          'sandwich',
          true,
          false,
          'assets/videos/lunch-routine/lunch-02-sandwich-idle.mp4',
        ),
        (
          'fruit',
          true,
          false,
          'assets/videos/lunch-routine/lunch-03-fruit-idle.mp4',
        ),
      ],
    );
    expect(
      [
        for (final step in PetLesson.steps)
          if (step.idle.isVideo || step.action.isVideo)
            (step.id, step.idle.isVideo, step.action.isVideo, path(step.idle)),
      ],
      [
        ('bowl', true, false, 'assets/videos/pet-routine/pet-01-bowl-idle.mp4'),
        (
          'scoop',
          true,
          false,
          'assets/videos/pet-routine/pet-02-scoop-idle.mp4',
        ),
        (
          'place',
          true,
          false,
          'assets/videos/pet-routine/pet-03-place-idle.mp4',
        ),
        (
          'water',
          true,
          false,
          'assets/videos/pet-routine/pet-04-water-idle.mp4',
        ),
      ],
    );
    expect(
      [
        for (final step in FlowerLesson.steps)
          if (step.idle.isVideo || step.action.isVideo)
            (step.id, step.idle.isVideo, step.action.isVideo, path(step.idle)),
      ],
      [
        (
          'pot',
          true,
          false,
          'assets/videos/flower-routine/flower-01-pot-idle.mp4',
        ),
        (
          'soil',
          true,
          false,
          'assets/videos/flower-routine/flower-02-soil-idle.mp4',
        ),
        (
          'water',
          true,
          false,
          'assets/videos/flower-routine/flower-04-water-idle.mp4',
        ),
        (
          'sunlight',
          true,
          false,
          'assets/videos/flower-routine/flower-05-sunlight-idle.mp4',
        ),
      ],
    );
    expect(FlowerLesson.steps[2].idle.isVideo, isFalse);
    for (final step in [
      ...LunchLesson.steps,
      ...PetLesson.steps,
      ...FlowerLesson.steps,
    ]) {
      expect(step.action.isVideo, isFalse, reason: step.id);
    }

    final player = File(
      'lib/screens/learn/morning_routine_screen.dart',
    ).readAsStringSync();
    expect(player, contains('final loop = phase == RoutinePhase.idle;'));
    expect(player, contains('await next.setLooping(loop);'));
  });

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

  test('Plant a Flower walks pot through sunlight', () {
    expectLesson(
      steps: FlowerLesson.steps,
      ids: ['pot', 'soil', 'seed', 'water', 'sunlight'],
      firstLabel: 'Pot',
      lastId: 'sunlight',
      lastLabel: 'Sunlight',
      finale: FlowerLesson.rewardForComplete().message,
      topicId: 'plant_a_flower',
      route: '/learn/plant-a-flower',
    );
    expect(
      FlowerLesson.rewardForComplete().message,
      'Amazing! Piku planted a flower!',
    );
    expect(
      FlowerLesson.actionStillDuration,
      MorningRoutine.actionStillDuration,
    );
  });

  testWidgets('each lesson opens on its first action', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final cases = <(Widget, String, String)>[
      (const GetReadyForBedScreen(), 'Get Ready for Bed!', 'Pajamas'),
      (const CleanUpToysScreen(), 'Clean Up Toys!', 'Pick up'),
      (const PackLunchScreen(), 'Pack Lunch!', 'Lunchbox'),
      (const FeedAPetScreen(), 'Feed a Pet!', 'Bowl'),
      (const PlantAFlowerScreen(), 'Plant a Flower!', 'Pot'),
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

  testWidgets('School tray lists the chore lessons', (tester) async {
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
    expect(find.text('Plant a Flower'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
