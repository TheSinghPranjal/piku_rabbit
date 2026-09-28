import 'package:flutter/material.dart';

/// One learning topic under the Learn activity screen.
class LearnTopicSpec {
  const LearnTopicSpec({
    required this.id,
    required this.label,
    required this.icon,
    required this.accent,
    this.route,
  });

  final String id;
  final String label;
  final IconData icon;
  final Color accent;

  /// Dedicated activity route when ready; null → placeholder.
  final String? route;

  bool get hasActivity => route != null;
}

/// All topics shown in the Learn tray (matches former Learn hub list).
abstract final class LearnTopics {
  static const all = <LearnTopicSpec>[
    LearnTopicSpec(
      id: 'alphabet',
      label: 'Alphabet',
      icon: Icons.abc_rounded,
      accent: Color(0xFF64B5F6),
      route: '/learn/alphabet',
    ),
    LearnTopicSpec(
      id: 'numbers',
      label: 'Numbers',
      icon: Icons.looks_one_rounded,
      accent: Color(0xFFFFB74D),
      route: '/learn/numbers',
    ),
    // LearnTopicSpec(
    //   id: 'words',
    //   label: 'Words',
    //   icon: Icons.spellcheck_rounded,
    //   accent: Color(0xFF81C784),
    // ),
    // LearnTopicSpec(
    //   id: 'colours',
    //   label: 'Colours',
    //   icon: Icons.palette_rounded,
    //   accent: Color(0xFFF48FB1),
    // ),
    // LearnTopicSpec(
    //   id: 'shapes',
    //   label: 'Shapes',
    //   icon: Icons.category_rounded,
    //   accent: Color(0xFFBA68C8),
    // ),
    // LearnTopicSpec(
    //   id: 'animals',
    //   label: 'Animals',
    //   icon: Icons.pets_rounded,
    //   accent: Color(0xFFA1887F),
    // ),
    // LearnTopicSpec(
    //   id: 'months',
    //   label: 'Months',
    //   icon: Icons.calendar_month_rounded,
    //   accent: Color(0xFF4DB6AC),
    // ),
    // LearnTopicSpec(
    //   id: 'weekdays',
    //   label: 'Weekdays',
    //   icon: Icons.view_week_rounded,
    //   accent: Color(0xFF90CAF9),
    // ),
    // LearnTopicSpec(
    //   id: 'weather',
    //   label: 'Weather',
    //   icon: Icons.wb_cloudy_rounded,
    //   accent: Color(0xFF80DEEA),
    // ),
    // LearnTopicSpec(
    //   id: 'body_parts',
    //   label: 'Body Parts',
    //   icon: Icons.accessibility_new_rounded,
    //   accent: Color(0xFFEF9A9A),
    // ),
    // LearnTopicSpec(
    //   id: 'fruits_veggies',
    //   label: 'Fruits & Veggies',
    //   icon: Icons.eco_rounded,
    //   accent: Color(0xFFAED581),
    // ),
    // LearnTopicSpec(
    //   id: 'opposites',
    //   label: 'Opposites',
    //   icon: Icons.compare_arrows_rounded,
    //   accent: Color(0xFFFFCC80),
    // ),
    // LearnTopicSpec(
    //   id: 'emotions',
    //   label: 'Emotions',
    //   icon: Icons.emoji_emotions_rounded,
    //   accent: Color(0xFFFFF176),
    // ),
    // LearnTopicSpec(
    //   id: 'vehicles',
    //   label: 'Vehicles',
    //   icon: Icons.directions_car_rounded,
    //   accent: Color(0xFF90A4AE),
    // ),
    // LearnTopicSpec(
    //   id: 'music',
    //   label: 'Music',
    //   icon: Icons.music_note_rounded,
    //   accent: Color(0xFFCE93D8),
    // ),
    // LearnTopicSpec(
    //   id: 'nature',
    //   label: 'Nature',
    //   icon: Icons.park_rounded,
    //   accent: Color(0xFF66BB6A),
    // ),
  ];

  static LearnTopicSpec? byId(String id) {
    for (final t in all) {
      if (t.id == id) return t;
    }
    return null;
  }
}

/// Alphabet segment videos (A–Z in order).
abstract final class AlphabetVideos {
  static const folder = 'assets/videos/learn/alphabets';

  static const segments = <String>[
    '$folder/Bao_speaking_alphabet_AtoD.mp4',
    '$folder/Bao_speaking_alphabet_EtoH.mp4',
    '$folder/Bao_speaking_alphabet_ItoL.mp4',
    '$folder/Bao_speaking_alphabet_MtoP.mp4',
    '$folder/Bao_speaking_alphabet_QtoT.mp4',
    '$folder/Bao_speaking_alphabet_UtoX.mp4',
    '$folder/Bao_speaking_alphabet_YtoZ.mp4',
  ];

  static const labels = <String>[
    'A – D',
    'E – H',
    'I – L',
    'M – P',
    'Q – T',
    'U – X',
    'Y – Z',
  ];
}

/// One Piku counting clip. Earlier clips loop until Next. The last clip
/// plays through once, then the lesson rewards.
class NumberSegment {
  const NumberSegment({
    required this.asset,
    required this.poster,
    required this.label,
  });

  final String asset;
  final String poster;
  final String label;
}

/// Piku counting lesson (1–20). Filenames stay stable so a later
/// regeneration of clips 12–16 and 16–20 can replace the files in place.
abstract final class NumberVideos {
  static const folder = 'assets/videos/learn/numbers';
  static const posterFolder = 'assets/images/learn/numbers';

  static const segments = <NumberSegment>[
    NumberSegment(
      asset: '$folder/piku-numbers-01-04.mp4',
      poster: '$posterFolder/piku-school-number-01.png',
      label: '1 – 4',
    ),
    NumberSegment(
      asset: '$folder/piku-numbers-04-08.mp4',
      poster: '$posterFolder/piku-school-number-04.png',
      label: '4 – 8',
    ),
    NumberSegment(
      asset: '$folder/piku-numbers-08-12.mp4',
      poster: '$posterFolder/piku-school-number-08.png',
      label: '8 – 12',
    ),
    NumberSegment(
      asset: '$folder/piku-numbers-12-16.mp4',
      poster: '$posterFolder/piku-school-number-12.png',
      label: '12 – 16',
    ),
    NumberSegment(
      asset: '$folder/piku-numbers-16-20.mp4',
      poster: '$posterFolder/piku-school-number-16.png',
      label: '16 – 20',
    ),
  ];

  /// Last frame of 16–20, shown once that clip has finished.
  static const finalePoster = '$posterFolder/piku-school-number-20.png';
}

/// Next / reward decisions for the counting lesson, independent of the player.
class CountingLessonProgress {
  const CountingLessonProgress({this.index = 0, this.finaleCompleted = false});

  final int index;
  final bool finaleCompleted;

  bool get isFinale => index >= NumberVideos.segments.length - 1;

  /// Earlier clips offer Next. The last clip rewards on its own after one play.
  bool get showsNext => !isFinale;

  bool get shouldReward => isFinale && finaleCompleted;

  NumberSegment get segment => NumberVideos.segments[index];

  /// Poster while the clip loads, or the closing still after 16–20 finishes.
  String get poster =>
      shouldReward ? NumberVideos.finalePoster : segment.poster;

  CountingLessonProgress advance() {
    if (!showsNext) return this;
    return CountingLessonProgress(index: index + 1);
  }

  /// A clip reached its end. Only the finale counts; earlier clips loop.
  CountingLessonProgress onClipFinished() {
    if (!isFinale || finaleCompleted) return this;
    return CountingLessonProgress(index: index, finaleCompleted: true);
  }
}
