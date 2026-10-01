import 'package:flutter/material.dart';

import 'morning_routine.dart';
import 'rewards.dart';

/// Shared star card for the bed, toys, lunch, pet, and flower lessons.
abstract final class ChoreLessonRules {
  static RewardResult rewardForStep(String message) {
    return MorningRoutineRules.rewardForStep(message);
  }

  static RewardResult rewardForComplete(String message) {
    return RewardResult(
      stars: MorningRoutineRules.stars,
      magicBeans: MorningRoutineRules.magicBeans,
      message: message,
    );
  }
}

/// Get Ready for Bed. Get-in-bed idle and action are videos. The other rows
/// stay stills.
abstract final class BedLesson {
  static const videoFolder = 'assets/videos/bed-routine';
  static const imageFolder = 'assets/images/bed-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() =>
      ChoreLessonRules.rewardForComplete('Amazing! Piku is ready for bed!');

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'pajamas',
      title: 'Pajamas',
      actionLabel: 'Pajamas',
      icon: Icons.checkroom_rounded,
      praise: 'Piku is in cozy pajamas!',
      idle: RoutineClip.image('$imageFolder/piku-bed-01-pajamas-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-bed-01-pajamas-after.jpg'),
    ),
    RoutineStep(
      id: 'brush-teeth',
      title: 'Brush teeth',
      actionLabel: 'Brush',
      icon: Icons.brush_rounded,
      praise: 'Piku\'s teeth are sparkling!',
      idle: RoutineClip.image(
        '$imageFolder/piku-bed-02-brush-teeth-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-bed-02-brush-teeth-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'wash-face',
      title: 'Wash face',
      actionLabel: 'Wash face',
      icon: Icons.face_rounded,
      praise: 'What a fresh face!',
      idle: RoutineClip.image('$imageFolder/piku-bed-03-wash-face-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-bed-03-wash-face-after.jpg'),
    ),
    RoutineStep(
      id: 'get-in-bed',
      title: 'Get in bed',
      actionLabel: 'Get in bed',
      icon: Icons.bed_rounded,
      praise: 'Tucked in and cozy!',
      idle: RoutineClip.video('$videoFolder/bed-04-get-in-bed-idle.mp4'),
      action: RoutineClip.video('$videoFolder/bed-04-get-in-bed-action.mp4'),
    ),
    RoutineStep(
      id: 'lights-off',
      title: 'Lights off',
      actionLabel: 'Lights off',
      icon: Icons.nightlight_rounded,
      praise: 'Night night, Piku!',
      idle: RoutineClip.image('$imageFolder/piku-bed-05-lights-off-before.jpg'),
      action: RoutineClip.image(
        '$imageFolder/piku-bed-05-lights-off-after.jpg',
      ),
    ),
  ];
}

/// Clean Up Toys. Each idle is a video. Every action stays a still.
abstract final class ToysLesson {
  static const videoFolder = 'assets/videos/toys-routine';
  static const imageFolder = 'assets/images/toys-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() =>
      ChoreLessonRules.rewardForComplete('Amazing! Piku\'s toys are tidy!');

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'pick-up',
      title: 'Pick up',
      actionLabel: 'Pick up',
      icon: Icons.back_hand_rounded,
      praise: 'Toys picked up!',
      idle: RoutineClip.video('$videoFolder/toys-01-pick-up-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-toys-01-pick-up-after.jpg'),
    ),
    RoutineStep(
      id: 'sort',
      title: 'Sort',
      actionLabel: 'Sort',
      icon: Icons.category_rounded,
      praise: 'All sorted!',
      idle: RoutineClip.video('$videoFolder/toys-02-sort-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-toys-02-sort-after.jpg'),
    ),
    RoutineStep(
      id: 'put-in-boxes',
      title: 'Put in boxes',
      actionLabel: 'Boxes',
      icon: Icons.inventory_2_rounded,
      praise: 'In the boxes!',
      idle: RoutineClip.video('$videoFolder/toys-03-put-in-boxes-idle.mp4'),
      action: RoutineClip.image(
        '$imageFolder/piku-toys-03-put-in-boxes-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'shelf',
      title: 'Shelf',
      actionLabel: 'Shelf',
      icon: Icons.view_column_rounded,
      praise: 'Up on the shelf!',
      idle: RoutineClip.video('$videoFolder/toys-04-shelf-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-toys-04-shelf-after.jpg'),
    ),
    RoutineStep(
      id: 'tidy-room',
      title: 'Tidy room',
      actionLabel: 'Tidy up',
      icon: Icons.cleaning_services_rounded,
      praise: 'What a tidy room!',
      idle: RoutineClip.video('$videoFolder/toys-05-tidy-room-idle.mp4'),
      action: RoutineClip.image(
        '$imageFolder/piku-toys-05-tidy-room-after.jpg',
      ),
    ),
  ];
}

/// Pack Lunch. Sandwich idle and fruit idle are videos. Other rows stay stills.
abstract final class LunchLesson {
  static const videoFolder = 'assets/videos/lunch-routine';
  static const imageFolder = 'assets/images/lunch-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() =>
      ChoreLessonRules.rewardForComplete('Amazing! Piku\'s lunch is packed!');

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'lunchbox',
      title: 'Lunchbox',
      actionLabel: 'Lunchbox',
      icon: Icons.lunch_dining_rounded,
      praise: 'Lunchbox is out!',
      idle: RoutineClip.image('$imageFolder/piku-lunch-01-lunchbox-before.jpg'),
      action: RoutineClip.image(
        '$imageFolder/piku-lunch-01-lunchbox-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'sandwich',
      title: 'Sandwich',
      actionLabel: 'Sandwich',
      icon: Icons.bakery_dining_rounded,
      praise: 'Yummy sandwich!',
      idle: RoutineClip.video('$videoFolder/lunch-02-sandwich-idle.mp4'),
      action: RoutineClip.image(
        '$imageFolder/piku-lunch-02-sandwich-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'fruit',
      title: 'Fruit',
      actionLabel: 'Fruit',
      icon: Icons.eco_rounded,
      praise: 'Fruit packed!',
      idle: RoutineClip.video('$videoFolder/lunch-03-fruit-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-lunch-03-fruit-after.jpg'),
    ),
    RoutineStep(
      id: 'water',
      title: 'Water',
      actionLabel: 'Water',
      icon: Icons.water_drop_rounded,
      praise: 'Water bottle ready!',
      idle: RoutineClip.image('$imageFolder/piku-lunch-04-water-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-lunch-04-water-after.jpg'),
    ),
    RoutineStep(
      id: 'close-pack',
      title: 'Close pack',
      actionLabel: 'Pack it',
      icon: Icons.inventory_2_rounded,
      praise: 'Lunch is packed!',
      idle: RoutineClip.image(
        '$imageFolder/piku-lunch-05-close-pack-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-lunch-05-close-pack-after.jpg',
      ),
    ),
  ];
}

/// Feed a Pet. Bowl, scoop, place, and water idles are videos.
/// Clean-up idle and every action stay stills.
abstract final class PetLesson {
  static const videoFolder = 'assets/videos/pet-routine';
  static const imageFolder = 'assets/images/pet-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() =>
      ChoreLessonRules.rewardForComplete('Amazing! Piku fed the pet!');

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'bowl',
      title: 'Bowl',
      actionLabel: 'Bowl',
      icon: Icons.flatware_rounded,
      praise: 'Bowl is ready!',
      idle: RoutineClip.video('$videoFolder/pet-01-bowl-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-pet-01-bowl-after.jpg'),
    ),
    RoutineStep(
      id: 'scoop',
      title: 'Scoop',
      actionLabel: 'Scoop',
      icon: Icons.restaurant_rounded,
      praise: 'Nice scoop!',
      idle: RoutineClip.video('$videoFolder/pet-02-scoop-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-pet-02-scoop-after.jpg'),
    ),
    RoutineStep(
      id: 'place',
      title: 'Place',
      actionLabel: 'Place',
      icon: Icons.room_service_rounded,
      praise: 'Food is in the bowl!',
      idle: RoutineClip.video('$videoFolder/pet-03-place-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-pet-03-place-after.jpg'),
    ),
    RoutineStep(
      id: 'water',
      title: 'Water',
      actionLabel: 'Water',
      icon: Icons.water_drop_rounded,
      praise: 'Fresh water!',
      idle: RoutineClip.video('$videoFolder/pet-04-water-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-pet-04-water-after.jpg'),
    ),
    RoutineStep(
      id: 'clean-up',
      title: 'Clean up',
      actionLabel: 'Clean up',
      icon: Icons.cleaning_services_rounded,
      praise: 'All cleaned up!',
      idle: RoutineClip.image('$imageFolder/piku-pet-05-clean-up-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-pet-05-clean-up-after.jpg'),
    ),
  ];
}

/// Plant a Flower. Pot, soil, water, and sunlight idles are videos.
/// Seed idle and every action stay stills.
abstract final class FlowerLesson {
  static const videoFolder = 'assets/videos/flower-routine';
  static const imageFolder = 'assets/images/flower-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() =>
      ChoreLessonRules.rewardForComplete('Amazing! Piku planted a flower!');

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'pot',
      title: 'Pot',
      actionLabel: 'Pot',
      icon: Icons.yard_rounded,
      praise: 'Pot is ready!',
      idle: RoutineClip.video('$videoFolder/flower-01-pot-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-flower-01-pot-after.jpg'),
    ),
    RoutineStep(
      id: 'soil',
      title: 'Soil',
      actionLabel: 'Soil',
      icon: Icons.grass_rounded,
      praise: 'Soil is in the pot!',
      idle: RoutineClip.video('$videoFolder/flower-02-soil-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-flower-02-soil-after.jpg'),
    ),
    RoutineStep(
      id: 'seed',
      title: 'Seed',
      actionLabel: 'Seed',
      icon: Icons.spa_rounded,
      praise: 'Seed is planted!',
      idle: RoutineClip.image('$imageFolder/piku-flower-03-seed-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-flower-03-seed-after.jpg'),
    ),
    RoutineStep(
      id: 'water',
      title: 'Water',
      actionLabel: 'Water',
      icon: Icons.water_drop_rounded,
      praise: 'A little drink!',
      idle: RoutineClip.video('$videoFolder/flower-04-water-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-flower-04-water-after.jpg'),
    ),
    RoutineStep(
      id: 'sunlight',
      title: 'Sunlight',
      actionLabel: 'Sunlight',
      icon: Icons.wb_sunny_rounded,
      praise: 'Hello, sunshine!',
      idle: RoutineClip.video('$videoFolder/flower-05-sunlight-idle.mp4'),
      action: RoutineClip.image(
        '$imageFolder/piku-flower-05-sunlight-after.jpg',
      ),
    ),
  ];
}
