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
