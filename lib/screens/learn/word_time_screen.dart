import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/word_time.dart';
import '../../services/word_time_speech.dart';
import '../../theme/tt_colors.dart';
import '../../theme/tt_typography.dart';
import '../../widgets/back_button_circle.dart';
import '../../widgets/bounce_button.dart';

/// Word Time — ten classroom stills. The app speaks each letter, then the word.
///
/// Replay says the current word again. Next stops speech and moves on.
/// On the last word, Next returns to the School tray.
class WordTimeScreen extends StatefulWidget {
  const WordTimeScreen({
    super.key,
    this.speaker,
    this.initialIndex = 0,
    this.letterPause = WordTimeLesson.letterPause,
  });

  /// Platform speech when null. Tests pass a fake.
  final WordTimeSpeaker? speaker;

  final int initialIndex;
  final Duration letterPause;

  @override
  State<WordTimeScreen> createState() => _WordTimeScreenState();
}

class _WordTimeScreenState extends State<WordTimeScreen> {
  late final WordTimeNarration _narration;
  late WordTimeProgress _progress;
  int? _highlight;
  var _disposed = false;
  var _finished = false;

  @override
  void initState() {
    super.initState();
    final last = WordTimeLesson.words.length - 1;
    final index = widget.initialIndex < 0
        ? 0
        : (widget.initialIndex > last ? last : widget.initialIndex);
    _progress = WordTimeProgress(index: index);
    _narration = WordTimeNarration(
      speaker: widget.speaker ?? FlutterTtsWordTimeSpeaker(),
      letterPause: widget.letterPause,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _disposed) return;
      unawaited(_narration.play(_progress.word.word, _onCue));
    });
  }

  void _onCue(int highlight) {
    if (!mounted || _disposed) return;
    setState(() => _highlight = highlight);
  }

  Future<void> _replay() async {
    if (_finished || _disposed) return;
    setState(() => _highlight = null);
    await _narration.play(_progress.word.word, _onCue);
  }

  Future<void> _next() async {
    if (_finished || _disposed) return;
    if (_progress.isLast) {
      _finished = true;
      await _narration.stop();
      if (!mounted || _disposed) return;
      _pop(true);
      return;
    }
    final next = _progress.advance();
    setState(() {
      _progress = next;
      _highlight = null;
    });
    await _narration.play(next.word.word, _onCue);
  }

  Future<void> _back() async {
    if (_finished || _disposed) return;
    _finished = true;
    await _narration.stop();
    if (!mounted || _disposed) return;
    _pop(false);
  }

  void _pop(bool completed) {
    final router = GoRouter.maybeOf(context);
    if (router != null) {
      if (router.canPop()) router.pop(completed);
      return;
    }
    final navigator = Navigator.of(context);
    if (navigator.canPop()) navigator.pop(completed);
  }

  @override
  void dispose() {
    _disposed = true;
    unawaited(_narration.stop());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = _progress.word;

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            word.asset,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            gaplessPlayback: true,
            semanticLabel: 'Piku teaching ${word.word}',
            errorBuilder: (context, error, stackTrace) =>
                const ColoredBox(color: Color(0xFFE3F2FD)),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 64,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TtBackButton(
                            onPressed: () => unawaited(_back()),
                          ),
                        ),
                      ),
                      _ProgressPill(label: _progress.label),
                    ],
                  ),
                ),
                const Spacer(),
                _LetterCard(word: word.word, highlight: _highlight),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _WordTimeAction(
                      label: 'Replay',
                      icon: Icons.replay_rounded,
                      onPressed: () => unawaited(_replay()),
                    ),
                    const SizedBox(width: 16),
                    _WordTimeAction(
                      label: 'Next',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () => unawaited(_next()),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressPill extends StatelessWidget {
  const _ProgressPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: TTColors.creamWhite.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(TTSpacing.radiusPill),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Text(
          label,
          style: TTTypography.title(
            color: TTColors.darkBrown,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _LetterCard extends StatelessWidget {
  const _LetterCard({required this.word, required this.highlight});

  final String word;
  final int? highlight;

  @override
  Widget build(BuildContext context) {
    final letters = word.split('');
    final whole = highlight == WordTimeLesson.wholeWord;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: TTColors.creamWhite.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: whole ? TTColors.golden : Colors.white,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: TTColors.darkBrown.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < letters.length; i++)
                _LetterGlyph(
                  letter: letters[i],
                  index: i,
                  lit: whole || highlight == i,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LetterGlyph extends StatelessWidget {
  const _LetterGlyph({
    required this.letter,
    required this.index,
    required this.lit,
  });

  final String letter;
  final int index;
  final bool lit;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: lit ? 1.12 : 1,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: lit ? TTColors.goldenBright : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          letter,
          key: ValueKey('word-letter-$index-${lit ? 'lit' : 'dim'}'),
          style: TTTypography.headline(
            color: lit
                ? TTColors.darkBrown
                : TTColors.softBrown.withValues(alpha: 0.45),
          ).copyWith(fontSize: 34, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _WordTimeAction extends StatelessWidget {
  const _WordTimeAction({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BounceButton(
      onPressed: onPressed,
      semanticLabel: label,
      child: Container(
        height: TTSpacing.touchMin,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: TTColors.creamWhite.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(TTSpacing.radiusPill),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: TTColors.darkBrown.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: TTColors.skyDeep),
            const SizedBox(width: 6),
            Text(label, style: TTTypography.button(color: TTColors.darkBrown)),
          ],
        ),
      ),
    );
  }
}
