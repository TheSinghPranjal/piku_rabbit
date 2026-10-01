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
    LearnTopicSpec(
      id: 'morning_routine',
      label: 'Morning Routine',
      icon: Icons.wb_sunny_rounded,
      accent: Color(0xFFFFD54F),
      route: '/learn/morning-routine',
    ),
    LearnTopicSpec(
      id: 'get_ready_for_bed',
      label: 'Get Ready for Bed',
      icon: Icons.bedtime_rounded,
      accent: Color(0xFF9575CD),
      route: '/learn/get-ready-for-bed',
    ),
    LearnTopicSpec(
      id: 'clean_up_toys',
      label: 'Clean Up Toys',
      icon: Icons.extension_rounded,
      accent: Color(0xFF4DD0E1),
      route: '/learn/clean-up-toys',
    ),
    LearnTopicSpec(
      id: 'pack_lunch',
      label: 'Pack Lunch',
      icon: Icons.lunch_dining_rounded,
      accent: Color(0xFFAED581),
      route: '/learn/pack-lunch',
    ),
    LearnTopicSpec(
      id: 'feed_a_pet',
      label: 'Feed a Pet',
      icon: Icons.pets_rounded,
      accent: Color(0xFFFFAB91),
      route: '/learn/feed-a-pet',
    ),
    LearnTopicSpec(
      id: 'plant_a_flower',
      label: 'Plant a Flower',
      icon: Icons.local_florist_rounded,
      accent: Color(0xFFF48FB1),
      route: '/learn/plant-a-flower',
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

/// One Piku alphabet clip. Earlier clips loop until Next. The last clip
/// plays through once, then the lesson rewards.
class AlphabetSegment {
  const AlphabetSegment({required this.asset, required this.label});

  final String asset;
  final String label;
}

/// Piku alphabet lesson (A–Z), one overlapping pair per clip.
abstract final class AlphabetVideos {
  static const folder = 'assets/videos/learn/alphabets';

  static const segments = <AlphabetSegment>[
    AlphabetSegment(asset: '$folder/piku-alphabet-A-B.mp4', label: 'A – B'),
    AlphabetSegment(asset: '$folder/piku-alphabet-B-C.mp4', label: 'B – C'),
    AlphabetSegment(asset: '$folder/piku-alphabet-C-D.mp4', label: 'C – D'),
    AlphabetSegment(asset: '$folder/piku-alphabet-D-E.mp4', label: 'D – E'),
    AlphabetSegment(asset: '$folder/piku-alphabet-E-F.mp4', label: 'E – F'),
    AlphabetSegment(asset: '$folder/piku-alphabet-F-G.mp4', label: 'F – G'),
    AlphabetSegment(asset: '$folder/piku-alphabet-G-H.mp4', label: 'G – H'),
    AlphabetSegment(asset: '$folder/piku-alphabet-H-I.mp4', label: 'H – I'),
    AlphabetSegment(asset: '$folder/piku-alphabet-I-J.mp4', label: 'I – J'),
    AlphabetSegment(asset: '$folder/piku-alphabet-J-K.mp4', label: 'J – K'),
    AlphabetSegment(asset: '$folder/piku-alphabet-K-L.mp4', label: 'K – L'),
    AlphabetSegment(asset: '$folder/piku-alphabet-L-M.mp4', label: 'L – M'),
    AlphabetSegment(asset: '$folder/piku-alphabet-M-N.mp4', label: 'M – N'),
    AlphabetSegment(asset: '$folder/piku-alphabet-N-O.mp4', label: 'N – O'),
    AlphabetSegment(asset: '$folder/piku-alphabet-O-P.mp4', label: 'O – P'),
    AlphabetSegment(asset: '$folder/piku-alphabet-P-Q.mp4', label: 'P – Q'),
    AlphabetSegment(asset: '$folder/piku-alphabet-Q-R.mp4', label: 'Q – R'),
    AlphabetSegment(asset: '$folder/piku-alphabet-R-S.mp4', label: 'R – S'),
    AlphabetSegment(asset: '$folder/piku-alphabet-S-T.mp4', label: 'S – T'),
    AlphabetSegment(asset: '$folder/piku-alphabet-T-U.mp4', label: 'T – U'),
    AlphabetSegment(asset: '$folder/piku-alphabet-U-V.mp4', label: 'U – V'),
    AlphabetSegment(asset: '$folder/piku-alphabet-V-W.mp4', label: 'V – W'),
    AlphabetSegment(asset: '$folder/piku-alphabet-W-X.mp4', label: 'W – X'),
    AlphabetSegment(asset: '$folder/piku-alphabet-X-Y.mp4', label: 'X – Y'),
    AlphabetSegment(asset: '$folder/piku-alphabet-Y-Z.mp4', label: 'Y – Z'),
  ];
}

/// Next / reward decisions for the alphabet lesson, independent of the player.
class AlphabetLessonProgress {
  const AlphabetLessonProgress({this.index = 0, this.finaleCompleted = false});

  final int index;
  final bool finaleCompleted;

  bool get isFinale => index >= AlphabetVideos.segments.length - 1;

  /// Earlier clips offer Next. Y–Z rewards on its own after one play.
  bool get showsNext => !isFinale;

  bool get shouldReward => isFinale && finaleCompleted;

  AlphabetSegment get segment => AlphabetVideos.segments[index];

  AlphabetLessonProgress advance() {
    if (!showsNext) return this;
    return AlphabetLessonProgress(index: index + 1);
  }

  /// A clip reached its end. Only the finale counts; earlier clips loop.
  AlphabetLessonProgress onClipFinished() {
    if (!isFinale || finaleCompleted) return this;
    return AlphabetLessonProgress(index: index, finaleCompleted: true);
  }
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
