import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../models/character_media.dart';
import '../../models/morning_routine.dart';
import '../../models/rewards.dart';
import '../../services/stars_store.dart';
import '../../theme/tt_colors.dart';
import '../../theme/tt_typography.dart';
import '../../widgets/back_button_circle.dart';
import '../../widgets/bounce_button.dart';
import '../../widgets/status_bar.dart';
import '../drink/drink_water_screen.dart' show RewardPopup;

/// Morning routine — idle loop, one action, then the numbers reward card.
class MorningRoutineScreen extends StatelessWidget {
  const MorningRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RoutineLessonScreen(
      title: 'Morning Routine!',
      steps: MorningRoutine.steps,
      rewardForStep: MorningRoutineRules.rewardForStep,
      rewardForComplete: MorningRoutineRules.rewardForComplete,
    );
  }
}

/// Shared idle → action → reward → Next/Replay player for routine lessons.
class RoutineLessonScreen extends StatefulWidget {
  const RoutineLessonScreen({
    super.key,
    required this.title,
    required this.steps,
    required this.rewardForStep,
    required this.rewardForComplete,
    this.stillDuration = MorningRoutine.actionStillDuration,
  });

  final String title;
  final List<RoutineStep> steps;
  final RewardResult Function(String message) rewardForStep;
  final RewardResult Function() rewardForComplete;
  final Duration stillDuration;

  @override
  State<RoutineLessonScreen> createState() => _RoutineLessonScreenState();
}

class _RoutineLessonScreenState extends State<RoutineLessonScreen> {
  late RoutineLessonProgress _progress;
  bool _disposed = false;
  bool _rewardOpen = false;
  int _loadGen = 0;

  VideoPlayerController? _video;
  bool _ready = false;
  VoidCallback? _listener;
  Timer? _stillTimer;

  @override
  void initState() {
    super.initState();
    _progress = RoutineLessonProgress(steps: widget.steps);
    unawaited(_present());
  }

  Future<void> _disposeController(VideoPlayerController? controller) async {
    if (controller == null) return;
    try {
      controller.pause();
    } catch (_) {}
    await controller.dispose();
  }

  Future<void> _present() async {
    final gen = ++_loadGen;
    _stillTimer?.cancel();
    _stillTimer = null;
    final prev = _video;
    final prevListener = _listener;
    if (prevListener != null) {
      prev?.removeListener(prevListener);
    }
    _listener = null;

    final phase = _progress.phase;
    final step = _progress.step;
    final clip = phase == RoutinePhase.acting ? step.action : step.idle;
    final playVideo = clip.isVideo && phase != RoutinePhase.finale;

    if (mounted && !_disposed) {
      setState(() {
        _ready = !playVideo;
        _video = null;
      });
    } else {
      _ready = !playVideo;
      _video = null;
    }

    await _disposeController(prev);
    if (_disposed || !mounted || gen != _loadGen) return;

    if (phase == RoutinePhase.finale || phase == RoutinePhase.rewarded) {
      return;
    }

    if (!clip.isVideo) {
      if (phase == RoutinePhase.acting) {
        _stillTimer = Timer(widget.stillDuration, () {
          if (gen != _loadGen || _disposed) return;
          unawaited(_onActionEnded());
        });
      }
      return;
    }

    final next = VideoPlayerController.asset(clip.asset);
    try {
      await next.initialize();
      if (!mounted || _disposed || gen != _loadGen) {
        await _disposeController(next);
        return;
      }
      final loop = phase == RoutinePhase.idle;
      await next.setLooping(loop);
      await next.setVolume(1);
      if (!mounted || _disposed || gen != _loadGen) {
        await _disposeController(next);
        return;
      }
      await next.play();
      if (!mounted || _disposed || gen != _loadGen) {
        await _disposeController(next);
        return;
      }

      if (!loop) {
        _listener = () {
          final v = _video;
          if (v == null ||
              !identical(v, next) ||
              _disposed ||
              _rewardOpen ||
              !v.value.isInitialized) {
            return;
          }
          final duration = v.value.duration;
          if (duration <= Duration.zero) return;
          final nearEnd =
              v.value.position >= duration - const Duration(milliseconds: 120);
          if (nearEnd && !v.value.isPlaying) {
            unawaited(_onActionEnded());
          }
        };
        next.addListener(_listener!);
      }

      setState(() {
        _video = next;
        _ready = true;
      });
    } catch (_) {
      await _disposeController(next);
      if (!mounted || _disposed || gen != _loadGen) return;
      if (phase == RoutinePhase.acting) {
        setState(() {
          _progress = RoutineLessonProgress(
            index: _progress.index,
            steps: _progress.steps,
          );
        });
        unawaited(_present());
      }
    }
  }

  Future<void> _onAction() async {
    final next = _progress.startAction();
    if (identical(next, _progress)) return;
    setState(() => _progress = next);
    await _present();
  }

  Future<void> _onActionEnded() async {
    final next = _progress.finishAction();
    if (identical(next, _progress) || _rewardOpen) return;
    _rewardOpen = true;
    _progress = next;
    if (mounted) setState(() {});

    try {
      final reward = widget.rewardForStep(_progress.step.praise);
      await StarsStore.add(reward.stars);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!mounted || _disposed) return;
      await _showReward(reward, onContinue: () => Navigator.of(context).pop());
      if (!mounted || _disposed) return;
      setState(() => _progress = _progress.acknowledgeReward());
      if (_progress.showsFinale) {
        await StarsStore.add(widget.rewardForComplete().stars);
      }
    } finally {
      _rewardOpen = false;
      if (mounted && !_disposed) setState(() {});
    }
  }

  Future<void> _showReward(
    RewardResult reward, {
    required VoidCallback onContinue,
  }) {
    final character = CharacterMedia.idOf(context);
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Reward',
      barrierColor: TTColors.darkBrown.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, anim, _) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: RewardPopup(
              reward: reward,
              character: character,
              onContinue: onContinue,
            ),
          ),
        );
      },
      transitionBuilder: (context, anim, _, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }

  Future<void> _next() async {
    final next = _progress.next();
    if (identical(next, _progress)) return;
    setState(() => _progress = next);
    await _present();
  }

  Future<void> _replay() async {
    final next = _progress.replay();
    if (identical(next, _progress)) return;
    setState(() => _progress = next);
    await _present();
  }

  @override
  void dispose() {
    _disposed = true;
    _loadGen++;
    _stillTimer?.cancel();
    final listener = _listener;
    final video = _video;
    _listener = null;
    _video = null;
    _ready = false;
    if (listener != null) {
      video?.removeListener(listener);
    }
    video?.pause();
    video?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = _progress.step;
    final still = _progress.phase == RoutinePhase.acting
        ? step.action
        : step.idle;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFF8E1),
                  Color(0xFFFFE0B2),
                  Color(0xFFFFCC80),
                ],
              ),
            ),
          ),
          if (!_progress.showsFinale)
            _RoutineMedia(
              controller: _video,
              ready: _ready,
              still: still.isVideo ? null : still.asset,
            ),
          if (!_progress.showsFinale)
            const IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x8CFFF8F0), Colors.transparent],
                    stops: [0.0, 0.28],
                  ),
                ),
              ),
            ),
          if (!_progress.showsFinale)
            Column(
              children: [
                TinyStatusBar(
                  showCounters: true,
                  onSettings: () => context.push('/parent-gate'),
                  leading: TtBackButton(onPressed: () => context.pop(false)),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: TTTypography.headline(
                    color: TTColors.darkBrown,
                  ).copyWith(fontWeight: FontWeight.w900, fontSize: 30),
                ),
                Text(
                  step.title,
                  style: TTTypography.body(color: TTColors.darkBrown),
                ),
                const Spacer(),
                if (_progress.showsActionButton)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: BounceButton(
                      onPressed: _rewardOpen
                          ? null
                          : () => unawaited(_onAction()),
                      enabled: !_rewardOpen,
                      semanticLabel: step.actionLabel,
                      child: _RoutinePill(
                        label: step.actionLabel,
                        icon: step.icon,
                      ),
                    ),
                  ),
                if (_progress.showsNextAndReplay && !_rewardOpen)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BounceButton(
                          onPressed: () => unawaited(_replay()),
                          semanticLabel: 'Replay',
                          child: const _RoutinePill(
                            label: 'Replay',
                            icon: Icons.replay_rounded,
                          ),
                        ),
                        const SizedBox(width: 18),
                        BounceButton(
                          onPressed: () => unawaited(_next()),
                          semanticLabel: 'Next',
                          child: const _RoutinePill(
                            label: 'Next',
                            icon: Icons.arrow_forward_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          if (_progress.showsFinale)
            _Finale(
              reward: widget.rewardForComplete(),
              onReplay: () => unawaited(_replay()),
            ),
        ],
      ),
    );
  }
}

class _Finale extends StatelessWidget {
  const _Finale({required this.reward, required this.onReplay});

  final RewardResult reward;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF3C4), Color(0xFFFFE082), Color(0xFFFFB74D)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            TinyStatusBar(
              showCounters: true,
              onSettings: () => context.push('/parent-gate'),
              leading: TtBackButton(onPressed: () => context.pop(false)),
            ),
            Expanded(
              child: Center(
                child: RewardPopup(
                  reward: reward,
                  character: CharacterMedia.idOf(context),
                  onContinue: () => context.pop(true),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: BounceButton(
                onPressed: onReplay,
                semanticLabel: 'Replay',
                child: const _RoutinePill(
                  label: 'Replay',
                  icon: Icons.replay_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoutineMedia extends StatelessWidget {
  const _RoutineMedia({
    required this.controller,
    required this.ready,
    required this.still,
  });

  final VideoPlayerController? controller;
  final bool ready;
  final String? still;

  @override
  Widget build(BuildContext context) {
    final showVideo =
        ready && controller != null && controller!.value.isInitialized;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (still != null)
          Image.asset(still!, fit: BoxFit.cover, gaplessPlayback: true),
        if (showVideo)
          FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: controller!.value.size.width > 0
                  ? controller!.value.size.width
                  : 720,
              height: controller!.value.size.height > 0
                  ? controller!.value.size.height
                  : 1280,
              child: VideoPlayer(key: ValueKey(controller), controller!),
            ),
          ),
      ],
    );
  }
}

class _RoutinePill extends StatelessWidget {
  const _RoutinePill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 148, minHeight: 72),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF8E1), Color(0xFFFFE082), Color(0xFFFFB74D)],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF6C00).withValues(alpha: 0.28),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: const Color(0xFFEF6C00)),
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 220),
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TTTypography.body(
                color: TTColors.darkBrown,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
