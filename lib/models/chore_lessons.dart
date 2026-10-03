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

/// Pack Lunch 2. Every row is a still. Idle is the before JPEG and the
/// action is the after JPEG, shown for 2.5 seconds. There are no videos.
abstract final class Lunch2Lesson {
  static const imageFolder = 'assets/images/lunch2-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() =>
      ChoreLessonRules.rewardForComplete('Amazing! Piku packed a new lunch!');

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'lunchbox',
      title: 'Get lunchbox',
      actionLabel: 'Get lunchbox',
      icon: Icons.lunch_dining_rounded,
      praise: 'Lunchbox is out!',
      idle: RoutineClip.image(
        '$imageFolder/piku-lunch2-01-lunchbox-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-lunch2-01-lunchbox-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'sandwich',
      title: 'Add sandwich',
      actionLabel: 'Add sandwich',
      icon: Icons.bakery_dining_rounded,
      praise: 'Yummy sandwich!',
      idle: RoutineClip.image(
        '$imageFolder/piku-lunch2-02-sandwich-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-lunch2-02-sandwich-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'fruit',
      title: 'Add fruit',
      actionLabel: 'Add fruit',
      icon: Icons.eco_rounded,
      praise: 'Fruit packed!',
      idle: RoutineClip.image('$imageFolder/piku-lunch2-03-fruit-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-lunch2-03-fruit-after.jpg'),
    ),
    RoutineStep(
      id: 'water',
      title: 'Add water bottle',
      actionLabel: 'Add water bottle',
      icon: Icons.water_drop_rounded,
      praise: 'Water bottle ready!',
      idle: RoutineClip.image('$imageFolder/piku-lunch2-04-water-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-lunch2-04-water-after.jpg'),
    ),
    RoutineStep(
      id: 'close-pack',
      title: 'Close pack',
      actionLabel: 'Close pack',
      icon: Icons.inventory_2_rounded,
      praise: 'Lunch is packed!',
      idle: RoutineClip.image(
        '$imageFolder/piku-lunch2-05-close-pack-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-lunch2-05-close-pack-after.jpg',
      ),
    ),
  ];
}

/// Feed a Pet 2. Scoop and give-water idles are seamless loop videos.
/// Every other idle, and every action, stays a still.
abstract final class Pet2Lesson {
  static const videoFolder = 'assets/videos/pet2-routine';
  static const imageFolder = 'assets/images/pet2-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() =>
      ChoreLessonRules.rewardForComplete('Amazing! Piku fed another pet!');

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'bowl',
      title: 'Get bowl',
      actionLabel: 'Get bowl',
      icon: Icons.flatware_rounded,
      praise: 'Bowl is ready!',
      idle: RoutineClip.image('$imageFolder/piku-pet2-01-bowl-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-pet2-01-bowl-after.jpg'),
    ),
    RoutineStep(
      id: 'scoop',
      title: 'Scoop food',
      actionLabel: 'Scoop food',
      icon: Icons.restaurant_rounded,
      praise: 'Nice scoop!',
      idle: RoutineClip.video('$videoFolder/pet2-02-idle-loop.mp4'),
      action: RoutineClip.image('$imageFolder/piku-pet2-02-scoop-after.jpg'),
    ),
    RoutineStep(
      id: 'place',
      title: 'Place food',
      actionLabel: 'Place food',
      icon: Icons.room_service_rounded,
      praise: 'Food is in the bowl!',
      idle: RoutineClip.image('$imageFolder/piku-pet2-03-place-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-pet2-03-place-after.jpg'),
    ),
    RoutineStep(
      id: 'water',
      title: 'Give water',
      actionLabel: 'Give water',
      icon: Icons.water_drop_rounded,
      praise: 'Fresh water!',
      idle: RoutineClip.video('$videoFolder/pet2-04-idle-loop.mp4'),
      action: RoutineClip.image('$imageFolder/piku-pet2-04-water-after.jpg'),
    ),
    RoutineStep(
      id: 'clean-up',
      title: 'Clean up',
      actionLabel: 'Clean up',
      icon: Icons.cleaning_services_rounded,
      praise: 'All cleaned up!',
      idle: RoutineClip.image('$imageFolder/piku-pet2-05-clean-up-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-pet2-05-clean-up-after.jpg'),
    ),
  ];
}

/// Plant a Flower 2. Pot and soil idles are seamless loop videos.
/// Every other idle, and every action, stays a still.
abstract final class Flower2Lesson {
  static const videoFolder = 'assets/videos/flower2-routine';
  static const imageFolder = 'assets/images/flower2-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() => ChoreLessonRules.rewardForComplete(
    'Amazing! Piku planted another flower!',
  );

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'pot',
      title: 'Get pot',
      actionLabel: 'Get pot',
      icon: Icons.yard_rounded,
      praise: 'Pot is ready!',
      idle: RoutineClip.video('$videoFolder/flower2-01-idle-loop.mp4'),
      action: RoutineClip.image('$imageFolder/piku-flower2-01-pot-after.jpg'),
    ),
    RoutineStep(
      id: 'soil',
      title: 'Add soil',
      actionLabel: 'Add soil',
      icon: Icons.grass_rounded,
      praise: 'Soil is in the pot!',
      idle: RoutineClip.video('$videoFolder/flower2-02-idle-loop.mp4'),
      action: RoutineClip.image('$imageFolder/piku-flower2-02-soil-after.jpg'),
    ),
    RoutineStep(
      id: 'seed',
      title: 'Plant seed',
      actionLabel: 'Plant seed',
      icon: Icons.spa_rounded,
      praise: 'Seed is planted!',
      idle: RoutineClip.image('$imageFolder/piku-flower2-03-seed-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-flower2-03-seed-after.jpg'),
    ),
    RoutineStep(
      id: 'water',
      title: 'Water it',
      actionLabel: 'Water it',
      icon: Icons.water_drop_rounded,
      praise: 'A little drink!',
      idle: RoutineClip.image('$imageFolder/piku-flower2-04-water-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-flower2-04-water-after.jpg'),
    ),
    RoutineStep(
      id: 'sunlight',
      title: 'Sunlight',
      actionLabel: 'Sunlight',
      icon: Icons.wb_sunny_rounded,
      praise: 'Hello, sunshine!',
      idle: RoutineClip.image(
        '$imageFolder/piku-flower2-05-sunlight-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-flower2-05-sunlight-after.jpg',
      ),
    ),
  ];
}

/// Water the Plants. Every row is a still. Idle is the before JPEG and the
/// action is the after JPEG, shown for 2.5 seconds. There are no videos.
abstract final class WaterLesson {
  static const imageFolder = 'assets/images/water-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() =>
      ChoreLessonRules.rewardForComplete('Amazing! Piku watered the plants!');

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'watering-can',
      title: 'Get watering can',
      actionLabel: 'Get watering can',
      icon: Icons.water_drop_rounded,
      praise: 'Watering can is ready!',
      idle: RoutineClip.image(
        '$imageFolder/piku-water-01-watering-can-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-water-01-watering-can-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'fill-can',
      title: 'Fill watering can',
      actionLabel: 'Fill watering can',
      icon: Icons.opacity_rounded,
      praise: 'The can is full!',
      idle: RoutineClip.image('$imageFolder/piku-water-02-fill-can-before.jpg'),
      action: RoutineClip.image(
        '$imageFolder/piku-water-02-fill-can-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'water-flowers',
      title: 'Water flowers',
      actionLabel: 'Water flowers',
      icon: Icons.local_florist_rounded,
      praise: 'Flowers had a drink!',
      idle: RoutineClip.image(
        '$imageFolder/piku-water-03-water-flowers-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-water-03-water-flowers-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'small-plant',
      title: 'Water small plant',
      actionLabel: 'Water small plant',
      icon: Icons.grass_rounded,
      praise: 'The little plant is happy!',
      idle: RoutineClip.image(
        '$imageFolder/piku-water-04-small-plant-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-water-04-small-plant-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'finish',
      title: 'Finish gardening',
      actionLabel: 'Finish gardening',
      icon: Icons.park_rounded,
      praise: 'Gardening is done!',
      idle: RoutineClip.image('$imageFolder/piku-water-05-finish-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-water-05-finish-after.jpg'),
    ),
  ];
}

/// Drawing Time. Every row is a still. Idle is the before JPEG and the
/// action is the after JPEG, shown for 2.5 seconds. There are no videos.
abstract final class DrawLesson {
  static const imageFolder = 'assets/images/draw-routine';
  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static RewardResult rewardForStep(String message) =>
      ChoreLessonRules.rewardForStep(message);

  static RewardResult rewardForComplete() => ChoreLessonRules.rewardForComplete(
    'Amazing! Piku\'s artwork is on the fridge!',
  );

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'supplies',
      title: 'Get supplies',
      actionLabel: 'Get supplies',
      icon: Icons.palette_rounded,
      praise: 'Supplies are ready!',
      idle: RoutineClip.image('$imageFolder/piku-draw-01-supplies-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-draw-01-supplies-after.jpg'),
    ),
    RoutineStep(
      id: 'table',
      title: 'Set up table',
      actionLabel: 'Set up table',
      icon: Icons.table_restaurant_rounded,
      praise: 'The table is ready!',
      idle: RoutineClip.image('$imageFolder/piku-draw-02-table-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-draw-02-table-after.jpg'),
    ),
    RoutineStep(
      id: 'draw-picture',
      title: 'Draw picture',
      actionLabel: 'Draw picture',
      icon: Icons.draw_rounded,
      praise: 'What a picture!',
      idle: RoutineClip.image(
        '$imageFolder/piku-draw-03-draw-picture-before.jpg',
      ),
      action: RoutineClip.image(
        '$imageFolder/piku-draw-03-draw-picture-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'details',
      title: 'Add details',
      actionLabel: 'Add details',
      icon: Icons.brush_rounded,
      praise: 'Nice details!',
      idle: RoutineClip.image('$imageFolder/piku-draw-04-details-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-draw-04-details-after.jpg'),
    ),
    RoutineStep(
      id: 'display',
      title: 'Display artwork on the fridge',
      actionLabel: 'Display artwork',
      icon: Icons.kitchen_rounded,
      praise: 'On the fridge!',
      idle: RoutineClip.image('$imageFolder/piku-draw-05-display-before.jpg'),
      action: RoutineClip.image('$imageFolder/piku-draw-05-display-after.jpg'),
    ),
  ];
}
