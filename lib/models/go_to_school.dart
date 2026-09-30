import 'package:flutter/material.dart';

import 'morning_routine.dart';

/// Go to School lesson. Idle and action rows are the swap table:
/// a placeholder is [RoutineClip.image]; a finished clip is [RoutineClip.video].
///
/// Three clips stay stills until a real mp4 is dropped in:
/// shoes idle, bag action, and leave action.
abstract final class GoToSchool {
  static const videoFolder = 'assets/videos/school-routine';
  static const imageFolder = 'assets/images/school-routine';

  static const actionStillDuration = MorningRoutine.actionStillDuration;

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'dress',
      title: 'School dress',
      actionLabel: 'Dress',
      icon: Icons.checkroom_rounded,
      praise: 'Piku is dressed for school!',
      idle: RoutineClip.video('$videoFolder/school-01-dress-idle.mp4'),
      action: RoutineClip.video('$videoFolder/school-01-dress-action.mp4'),
    ),
    RoutineStep(
      id: 'tie',
      title: 'Tie',
      actionLabel: 'Tie',
      icon: Icons.straighten_rounded,
      praise: 'What a neat tie!',
      idle: RoutineClip.video('$videoFolder/school-02-tie-idle.mp4'),
      action: RoutineClip.video('$videoFolder/school-02-tie-action.mp4'),
    ),
    RoutineStep(
      id: 'shoes',
      title: 'School shoes',
      actionLabel: 'Shoes',
      icon: Icons.directions_walk_rounded,
      praise: 'Shoes on! Ready to go!',
      idle: RoutineClip.image('$imageFolder/piku-school-03-shoes-before.jpg'),
      action: RoutineClip.video('$videoFolder/school-03-shoes-action.mp4'),
    ),
    RoutineStep(
      id: 'bag',
      title: 'School bag',
      actionLabel: 'School bag',
      icon: Icons.shopping_bag_rounded,
      praise: 'Bag packed and ready!',
      idle: RoutineClip.video('$videoFolder/school-04-bag-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-school-04-bag-after.jpg'),
    ),
    RoutineStep(
      id: 'leave',
      title: 'Leave for school',
      actionLabel: "Let's go",
      icon: Icons.directions_run_rounded,
      praise: 'Off to school!',
      idle: RoutineClip.video('$videoFolder/school-05-leave-idle.mp4'),
      action: RoutineClip.image('$imageFolder/piku-school-05-leave-after.jpg'),
    ),
  ];
}
