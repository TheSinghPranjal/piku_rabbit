import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/chore_lessons.dart';
import 'package:piku_rabbit/models/learn_topics.dart';
import 'package:piku_rabbit/models/morning_routine.dart';
import 'package:piku_rabbit/models/rewards.dart';
import 'package:piku_rabbit/screens/learn/chore_lesson_screens.dart';
import 'package:piku_rabbit/screens/learn/learn_screen.dart';
import 'package:piku_rabbit/screens/learn/morning_routine_screen.dart';
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
          (step.id, step.idle.isVideo, step.action.isVideo),
      ],
      [
        ('lunchbox', false, false),
        ('sandwich', false, false),
        ('fruit', false, false),
        ('water', false, false),
        ('close-pack', false, false),
      ],
    );
    expect(
      [
        for (final step in PetLesson.steps)
          if (step.idle.isVideo || step.action.isVideo)
            (step.id, step.idle.isVideo, step.action.isVideo, path(step.idle)),
      ],
      [
        (
          'scoop',
          true,
          false,
          'assets/videos/pet-routine/pet-02-idle-loop.mp4',
        ),
        (
          'water',
          true,
          false,
          'assets/videos/pet-routine/pet-04-idle-loop.mp4',
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
          'assets/videos/flower-routine/flower-01-idle-loop.mp4',
        ),
        (
          'soil',
          true,
          false,
          'assets/videos/flower-routine/flower-02-idle-loop.mp4',
        ),
      ],
    );
    for (final steps in [WaterLesson.steps, DrawLesson.steps]) {
      expect(
        steps.any((step) => step.idle.isVideo || step.action.isVideo),
        isFalse,
      );
    }
    for (final step in [
      ...LunchLesson.steps,
      ...PetLesson.steps,
      ...FlowerLesson.steps,
      ...WaterLesson.steps,
      ...DrawLesson.steps,
    ]) {
      expect(step.action.isVideo, isFalse, reason: step.id);
    }

    final player = File('lib/screens/learn/morning_routine_screen.dart')
        .readAsStringSync();
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

  test('Pack Lunch walks get lunchbox through close pack', () {
    expectLesson(
      steps: LunchLesson.steps,
      ids: ['lunchbox', 'sandwich', 'fruit', 'water', 'close-pack'],
      firstLabel: 'Get lunchbox',
      lastId: 'close-pack',
      lastLabel: 'Close pack',
      finale: LunchLesson.rewardForComplete().message,
      topicId: 'pack_lunch',
      route: '/learn/pack-lunch',
    );
    expect(
      LunchLesson.rewardForComplete().message,
      'Amazing! Piku\'s lunch is packed!',
    );
    expect(LunchLesson.steps.map((step) => step.title), [
      'Get lunchbox',
      'Add sandwich',
      'Add fruit',
      'Add water bottle',
      'Close pack',
    ]);
  });

  test('Feed a Pet walks get bowl through clean up', () {
    expectLesson(
      steps: PetLesson.steps,
      ids: ['bowl', 'scoop', 'place', 'water', 'clean-up'],
      firstLabel: 'Get bowl',
      lastId: 'clean-up',
      lastLabel: 'Clean up',
      finale: PetLesson.rewardForComplete().message,
      topicId: 'feed_a_pet',
      route: '/learn/feed-a-pet',
    );
    expect(PetLesson.rewardForComplete().message, 'Amazing! Piku fed the pet!');
    expect(PetLesson.steps.map((step) => step.title), [
      'Get bowl',
      'Scoop food',
      'Place food',
      'Give water',
      'Clean up',
    ]);
  });

  test('Plant a Flower walks get pot through sunlight', () {
    expectLesson(
      steps: FlowerLesson.steps,
      ids: ['pot', 'soil', 'seed', 'water', 'sunlight'],
      firstLabel: 'Get pot',
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
    expect(FlowerLesson.steps.map((step) => step.title), [
      'Get pot',
      'Add soil',
      'Plant seed',
      'Water it',
      'Sunlight',
    ]);
  });

  test('Water the Plants walks watering can through finish gardening', () {
    expectLesson(
      steps: WaterLesson.steps,
      ids: [
        'watering-can',
        'fill-can',
        'water-flowers',
        'small-plant',
        'finish',
      ],
      firstLabel: 'Get watering can',
      lastId: 'finish',
      lastLabel: 'Finish gardening',
      finale: WaterLesson.rewardForComplete().message,
      topicId: 'water_the_plants',
      route: '/learn/water-the-plants',
    );
    expect(
      WaterLesson.rewardForComplete().message,
      'Amazing! Piku watered the plants!',
    );
    expect(WaterLesson.actionStillDuration, MorningRoutine.actionStillDuration);
    expect(WaterLesson.steps.map((step) => step.title), [
      'Get watering can',
      'Fill watering can',
      'Water flowers',
      'Water small plant',
      'Finish gardening',
    ]);
  });

  test('Drawing Time walks supplies through the fridge', () {
    expectLesson(
      steps: DrawLesson.steps,
      ids: ['supplies', 'table', 'draw-picture', 'details', 'display'],
      firstLabel: 'Get supplies',
      lastId: 'display',
      lastLabel: 'Display artwork on the fridge',
      finale: DrawLesson.rewardForComplete().message,
      topicId: 'drawing_time',
      route: '/learn/drawing-time',
    );
    expect(
      DrawLesson.rewardForComplete().message,
      'Amazing! Piku\'s artwork is on the fridge!',
    );
    expect(DrawLesson.actionStillDuration, MorningRoutine.actionStillDuration);
    expect(DrawLesson.steps.map((step) => step.title), [
      'Get supplies',
      'Set up table',
      'Draw picture',
      'Add details',
      'Display artwork on the fridge',
    ]);
  });

  testWidgets('the fridge step label fits a phone width', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      MaterialApp(
        home: RoutineLessonScreen(
          title: 'Drawing Time!',
          steps: [DrawLesson.steps.last],
          rewardForStep: DrawLesson.rewardForStep,
          rewardForComplete: DrawLesson.rewardForComplete,
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Display artwork on the fridge'), findsWidgets);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('each lesson opens on its first action', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final cases = <(Widget, String, String)>[
      (const GetReadyForBedScreen(), 'Get Ready for Bed!', 'Pajamas'),
      (const CleanUpToysScreen(), 'Clean Up Toys!', 'Pick up'),
      (const PackLunchScreen(), 'Pack Lunch!', 'Get lunchbox'),
      (const FeedAPetScreen(), 'Feed a Pet!', 'Get bowl'),
      (const PlantAFlowerScreen(), 'Plant a Flower!', 'Get pot'),
      (const WaterThePlantsScreen(), 'Water the Plants!', 'Get watering can'),
      (const DrawingTimeScreen(), 'Drawing Time!', 'Get supplies'),
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
    expect(find.text('Go to School'), findsOneWidget);
    expect(find.text('Get Ready for Bed'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chevron_right_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Clean Up Toys'), findsOneWidget);
    expect(find.text('Pack Lunch'), findsOneWidget);
    expect(find.text('Feed a Pet'), findsOneWidget);
    expect(find.text('Plant a Flower'), findsOneWidget);
    expect(find.text('Water the Plants'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chevron_right_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Drawing Time'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
