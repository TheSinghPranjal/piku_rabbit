import 'package:flutter/material.dart';

/// Video clip, or a still standing in until the mp4 exists.
enum RoutineAssetKind { video, image }

/// One idle or action asset. Flip [kind] and [asset] when a real mp4 lands.
class RoutineClip {
  const RoutineClip.video(this.asset) : kind = RoutineAssetKind.video;

  const RoutineClip.image(this.asset) : kind = RoutineAssetKind.image;

  final String asset;
  final RoutineAssetKind kind;

  bool get isVideo => kind == RoutineAssetKind.video;
}

/// One morning-routine step: looping idle, then a single action.
///
/// [loopAction] keeps the action video looping after the child taps the
/// button. The reward still opens after the first play-through. Default
/// is one play, then a hold on the last frame.
class RoutineStep {
  const RoutineStep({
    required this.id,
    required this.title,
    required this.actionLabel,
    required this.icon,
    required this.praise,
    required this.idle,
    required this.action,
    this.loopAction = false,
  });

  final String id;
  final String title;
  final String actionLabel;
  final IconData icon;
  final String praise;
  final RoutineClip idle;
  final RoutineClip action;
  final bool loopAction;
}

/// First pass of a looping action clip.
///
/// True when [position] is within 120ms of [duration] (the same window a
/// one-shot action uses) or the playhead jumped back after passing the
/// midpoint, which is how a seamless loop reports the seam.
bool loopingActionReachedEnd({
  required Duration position,
  required Duration duration,
  required Duration furthest,
}) {
  if (duration <= Duration.zero) return false;
  final nearEnd = position >= duration - const Duration(milliseconds: 120);
  final wrapped =
      furthest > duration ~/ 2 &&
      position + const Duration(milliseconds: 400) < furthest;
  return nearEnd || wrapped;
}

enum RoutinePhase { idle, acting, rewarded, finale }

/// Morning routine lesson. Idle and action rows are the swap table:
/// a placeholder is [RoutineClip.image]; a finished clip is [RoutineClip.video].
abstract final class MorningRoutine {
  static const videoFolder = 'assets/videos/routine';
  static const imageFolder = 'assets/images/routine';

  /// How long a missing action still stays up before the reward card.
  static const actionStillDuration = Duration(milliseconds: 2500);

  static const steps = <RoutineStep>[
    RoutineStep(
      id: 'waking',
      title: 'Waking up',
      actionLabel: 'Wake up',
      icon: Icons.wb_sunny_rounded,
      praise: 'Piku is awake and ready!',
      idle: RoutineClip.video('$videoFolder/piku-routine-01-waking-idle.mp4'),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-01-waking-action.mp4',
      ),
    ),
    RoutineStep(
      id: 'brushing',
      title: 'Brushing',
      actionLabel: 'Brush',
      icon: Icons.brush_rounded,
      praise: 'Piku\'s teeth are sparkling!',
      idle: RoutineClip.video('$videoFolder/piku-routine-02-brushing-idle.mp4'),
      action: RoutineClip.image(
        '$imageFolder/piku-routine-02-brushing-after.jpg',
      ),
    ),
    RoutineStep(
      id: 'flossing',
      title: 'Flossing',
      actionLabel: 'Floss',
      icon: Icons.straighten_rounded,
      praise: 'Piku flossed so well!',
      idle: RoutineClip.video('$videoFolder/piku-routine-03-flossing-idle.mp4'),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-03-flossing-action.mp4',
      ),
    ),
    RoutineStep(
      id: 'hands',
      title: 'Cleaning hands',
      actionLabel: 'Wash hands',
      icon: Icons.back_hand_rounded,
      praise: 'Clean hands! Nice work!',
      idle: RoutineClip.video('$videoFolder/piku-routine-04-hands-idle.mp4'),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-04-hands-action.mp4',
      ),
    ),
    RoutineStep(
      id: 'face',
      title: 'Cleaning face',
      actionLabel: 'Wash face',
      icon: Icons.face_rounded,
      praise: 'What a fresh face!',
      idle: RoutineClip.video('$videoFolder/piku-routine-05-face-idle.mp4'),
      action: RoutineClip.video('$videoFolder/piku-routine-05-face-action.mp4'),
    ),
    RoutineStep(
      id: 'hairwash',
      title: 'Hair wash',
      actionLabel: 'Wash hair',
      icon: Icons.shower_rounded,
      praise: 'Piku\'s hair is so clean!',
      idle: RoutineClip.video('$videoFolder/piku-routine-06-hairwash-idle.mp4'),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-06-hairwash-action.mp4',
      ),
    ),
    RoutineStep(
      id: 'scrub',
      title: 'Scrub',
      actionLabel: 'Scrub',
      icon: Icons.bubble_chart_rounded,
      praise: 'Scrub-a-dub! All clean!',
      idle: RoutineClip.video('$videoFolder/piku-routine-07-scrub-idle.mp4'),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-07-scrub-action.mp4',
      ),
    ),
    RoutineStep(
      id: 'soap',
      title: 'Apply soap',
      actionLabel: 'Soap',
      icon: Icons.soap_rounded,
      praise: 'Soapy and sparkling!',
      idle: RoutineClip.video('$videoFolder/piku-routine-08-soap-idle.mp4'),
      action: RoutineClip.video('$videoFolder/piku-routine-08-soap-action.mp4'),
      loopAction: true,
    ),
    RoutineStep(
      id: 'bathing',
      title: 'Bathing',
      actionLabel: 'Bath',
      icon: Icons.bathtub_rounded,
      praise: 'Splash! Bath time done!',
      idle: RoutineClip.video('$videoFolder/piku-routine-09-bathing-idle.mp4'),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-09-bathing-action.mp4',
      ),
      loopAction: true,
    ),
    RoutineStep(
      id: 'towel',
      title: 'Drying with towel',
      actionLabel: 'Dry off',
      icon: Icons.dry_rounded,
      praise: 'All dry and cozy!',
      idle: RoutineClip.video('$videoFolder/piku-routine-10-towel-idle.mp4'),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-10-towel-action.mp4',
      ),
      loopAction: true,
    ),
    RoutineStep(
      id: 'dressed',
      title: 'Getting dressed',
      actionLabel: 'Get dressed',
      icon: Icons.checkroom_rounded,
      praise: 'Dressed and ready!',
      idle: RoutineClip.image(
        '$imageFolder/piku-routine-11-dressed-before.jpg',
      ),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-11-dressed-action.mp4',
      ),
    ),
    RoutineStep(
      id: 'hairdry',
      title: 'Hair dry',
      actionLabel: 'Dry hair',
      icon: Icons.air_rounded,
      praise: 'Hair dry and fluffy!',
      idle: RoutineClip.video('$videoFolder/piku-routine-12-hairdry-idle.mp4'),
      action: RoutineClip.video(
        '$videoFolder/piku-routine-12-hairdry-action.mp4',
      ),
      loopAction: true,
    ),
  ];
}

/// Next, replay, and finale decisions, independent of the player.
class RoutineLessonProgress {
  const RoutineLessonProgress({
    this.index = 0,
    this.phase = RoutinePhase.idle,
    this.steps = MorningRoutine.steps,
  });

  final int index;
  final RoutinePhase phase;
  final List<RoutineStep> steps;

  RoutineStep get step => steps[index];

  bool get isLast => index >= steps.length - 1;

  bool get showsActionButton => phase == RoutinePhase.idle;

  /// After the step reward, earlier steps offer Next and Replay.
  bool get showsNextAndReplay => phase == RoutinePhase.rewarded && !isLast;

  bool get showsFinale => phase == RoutinePhase.finale;

  RoutineLessonProgress startAction() {
    if (phase != RoutinePhase.idle) return this;
    return RoutineLessonProgress(
      index: index,
      phase: RoutinePhase.acting,
      steps: steps,
    );
  }

  RoutineLessonProgress finishAction() {
    if (phase != RoutinePhase.acting) return this;
    return RoutineLessonProgress(
      index: index,
      phase: RoutinePhase.rewarded,
      steps: steps,
    );
  }

  /// After the step reward card closes. The last step opens the finale.
  RoutineLessonProgress acknowledgeReward() {
    if (phase != RoutinePhase.rewarded) return this;
    if (!isLast) return this;
    return RoutineLessonProgress(
      index: index,
      phase: RoutinePhase.finale,
      steps: steps,
    );
  }

  RoutineLessonProgress next() {
    if (!showsNextAndReplay) return this;
    return RoutineLessonProgress(index: index + 1, steps: steps);
  }

  /// Replay from the reward buttons or from the finale, any number of times.
  RoutineLessonProgress replay() {
    if (phase != RoutinePhase.rewarded && phase != RoutinePhase.finale) {
      return this;
    }
    return RoutineLessonProgress(index: index, steps: steps);
  }
}
