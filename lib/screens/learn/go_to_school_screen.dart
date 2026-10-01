import 'package:flutter/material.dart';

import '../../models/go_to_school.dart';
import '../../models/rewards.dart';
import 'morning_routine_screen.dart';

/// Go to School — same idle, action, reward, Next, and Replay flow as
/// Morning Routine.
class GoToSchoolScreen extends StatelessWidget {
  const GoToSchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Go to School!',
      steps: GoToSchool.steps,
      stillDuration: GoToSchool.actionStillDuration,
      rewardForStep: GoToSchoolRules.rewardForStep,
      rewardForComplete: GoToSchoolRules.rewardForComplete,
    );
  }
}
