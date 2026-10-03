import 'package:flutter/material.dart';

import '../../models/chore_lessons.dart';
import 'morning_routine_screen.dart';

/// Get Ready for Bed — same player as Morning Routine.
class GetReadyForBedScreen extends StatelessWidget {
  const GetReadyForBedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Get Ready for Bed!',
      steps: BedLesson.steps,
      stillDuration: BedLesson.actionStillDuration,
      rewardForStep: BedLesson.rewardForStep,
      rewardForComplete: BedLesson.rewardForComplete,
    );
  }
}

/// Clean Up Toys — same player as Morning Routine.
class CleanUpToysScreen extends StatelessWidget {
  const CleanUpToysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Clean Up Toys!',
      steps: ToysLesson.steps,
      stillDuration: ToysLesson.actionStillDuration,
      rewardForStep: ToysLesson.rewardForStep,
      rewardForComplete: ToysLesson.rewardForComplete,
    );
  }
}

/// Pack Lunch — same player as Morning Routine.
class PackLunchScreen extends StatelessWidget {
  const PackLunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Pack Lunch!',
      steps: LunchLesson.steps,
      stillDuration: LunchLesson.actionStillDuration,
      rewardForStep: LunchLesson.rewardForStep,
      rewardForComplete: LunchLesson.rewardForComplete,
    );
  }
}

/// Plant a Flower — same player as Morning Routine.
class PlantAFlowerScreen extends StatelessWidget {
  const PlantAFlowerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Plant a Flower!',
      steps: FlowerLesson.steps,
      stillDuration: FlowerLesson.actionStillDuration,
      rewardForStep: FlowerLesson.rewardForStep,
      rewardForComplete: FlowerLesson.rewardForComplete,
    );
  }
}

/// Feed a Pet — same player as Morning Routine.
class FeedAPetScreen extends StatelessWidget {
  const FeedAPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Feed a Pet!',
      steps: PetLesson.steps,
      stillDuration: PetLesson.actionStillDuration,
      rewardForStep: PetLesson.rewardForStep,
      rewardForComplete: PetLesson.rewardForComplete,
    );
  }
}

/// Pack Lunch 2 — same player as Morning Routine.
class PackLunch2Screen extends StatelessWidget {
  const PackLunch2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Pack Lunch 2!',
      steps: Lunch2Lesson.steps,
      stillDuration: Lunch2Lesson.actionStillDuration,
      rewardForStep: Lunch2Lesson.rewardForStep,
      rewardForComplete: Lunch2Lesson.rewardForComplete,
    );
  }
}

/// Feed a Pet 2 — same player as Morning Routine.
class FeedAPet2Screen extends StatelessWidget {
  const FeedAPet2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Feed a Pet 2!',
      steps: Pet2Lesson.steps,
      stillDuration: Pet2Lesson.actionStillDuration,
      rewardForStep: Pet2Lesson.rewardForStep,
      rewardForComplete: Pet2Lesson.rewardForComplete,
    );
  }
}

/// Plant a Flower 2 — same player as Morning Routine.
class PlantAFlower2Screen extends StatelessWidget {
  const PlantAFlower2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Plant a Flower 2!',
      steps: Flower2Lesson.steps,
      stillDuration: Flower2Lesson.actionStillDuration,
      rewardForStep: Flower2Lesson.rewardForStep,
      rewardForComplete: Flower2Lesson.rewardForComplete,
    );
  }
}

/// Water the Plants — same player as Morning Routine.
class WaterThePlantsScreen extends StatelessWidget {
  const WaterThePlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Water the Plants!',
      steps: WaterLesson.steps,
      stillDuration: WaterLesson.actionStillDuration,
      rewardForStep: WaterLesson.rewardForStep,
      rewardForComplete: WaterLesson.rewardForComplete,
    );
  }
}

/// Drawing Time — same player as Morning Routine.
class DrawingTimeScreen extends StatelessWidget {
  const DrawingTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Drawing Time!',
      steps: DrawLesson.steps,
      stillDuration: DrawLesson.actionStillDuration,
      rewardForStep: DrawLesson.rewardForStep,
      rewardForComplete: DrawLesson.rewardForComplete,
    );
  }
}
