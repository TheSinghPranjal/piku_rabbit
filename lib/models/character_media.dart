import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'character.dart';
import 'character_bg_videos.dart';

/// Picks the clip a screen should play.
///
/// Bao's asset paths stay the source of truth. Piku substitutes a piku_* file
/// when one is bundled for that slot and otherwise keeps the Bao file. Every
/// other character uses Bao's media unchanged. See `docs/piku_media.md`.
abstract final class CharacterMedia {
  /// Piku's idle, bedroom, play, and eating loops are in the asset bundle.
  /// The reward celebration clip is not, so that slot stays on Bao's still.
  static const pikuClipsBundled = true;

  static const _bg = 'assets/videos/piku_character_screen_bg_video_list';

  static const genericIdle = '$_bg/piku_character_screen_bg_video.mp4';
  static const nightYawning =
      '$_bg/piku_character_screen_night_yawning_bg_video.mp4';
  static const morning = '$_bg/piku_character_screen_morning_bg_video.mp4';
  static const noon = '$_bg/piku_character_screen_noon_bg_video.mp4';
  static const evening = '$_bg/piku_character_screen_evening_bg_video.mp4';
  static const eatingAppleSpecial =
      '$_bg/piku_character_screen_bg_eating_apple_video.mp4';

  static const sleeping = 'assets/videos/wake/piku_sleeping_video.mp4';
  static const notFeeding = 'assets/videos/piku_not_feeding.mp4';

  static const appleIdle = 'assets/videos/feed/apple/piku_not_eating_apple.mp4';
  static const appleAction = 'assets/videos/feed/apple/piku_eating_apple.mp4';
  static const veggiesIdle =
      'assets/videos/feed/veggies/piku_not_eating_veggies.mp4';
  static const veggiesAction =
      'assets/videos/feed/veggies/piku_eating_veggies.mp4';
  static const riceIdle = 'assets/videos/feed/rice/piku_not_eating_rice.mp4';
  static const riceAction = 'assets/videos/feed/rice/piku_eating_rice.mp4';

  static const playHub = 'assets/videos/play/piku_play_screen_video.mp4';
  static const footballIdle =
      'assets/videos/play/football/piku_not_playing_football_video.mp4';
  static const footballAction =
      'assets/videos/play/football/piku_playing_football_video.mp4';
  static const cricketIdle =
      'assets/videos/play/cricket/piku_not_playing_cricket_video.mp4';
  static const cricketAction =
      'assets/videos/play/cricket/piku_playing_cricket_video.mp4';
  static const badmintonIdle =
      'assets/videos/play/badminton/piku_not_playing_badminton_video.mp4';
  static const badmintonAction =
      'assets/videos/play/badminton/piku_playing_badminton_video.mp4';
  static const danceIdle =
      'assets/videos/play/dance/piku_not_doing_dance_video.mp4';
  static const danceAction =
      'assets/videos/play/dance/piku_doing_dance_video.mp4';
  static const skippingIdle =
      'assets/videos/play/skipping/piku_not_doing_skipping_video.mp4';
  static const skippingAction =
      'assets/videos/play/skipping/piku_doing_skipping_video.mp4';

  /// Future reward loop. Not bundled yet; Bao's slot stays the still
  /// `bao_reward_celebrate.png`.
  static const celebration = 'assets/videos/reward/piku_celebration_loop.mp4';

  /// Bao path → Piku file. Used only when [pikuClipsBundled] is true.
  static const plannedOverrides = <String, String>{
    CharacterBgVideos.fallback: genericIdle,
    CharacterBgVideos.nightYawning: nightYawning,
    CharacterBgVideos.morning: morning,
    CharacterBgVideos.noon: noon,
    CharacterBgVideos.evening: evening,
    CharacterBgVideos.eatingApple: eatingAppleSpecial,
    'assets/videos/wake/bao_sleeping_video.mp4': sleeping,
    'assets/videos/bao_not_feeding.mp4': notFeeding,
    'assets/videos/feed/apple/bao_not_eating_apple.mp4': appleIdle,
    'assets/videos/feed/apple/bao_eating_apple.mp4': appleAction,
    'assets/videos/feed/veggies/bao_not_eating_veggies.mp4': veggiesIdle,
    'assets/videos/feed/veggies/bao_eating_veggies.mp4': veggiesAction,
    // Soup is the closest bowl meal; salad fills the veggies action.
    'assets/videos/feed/rice/bao_not_eating_rice.mp4': riceIdle,
    'assets/videos/feed/rice/bao_eating_rice.mp4': riceAction,
    'assets/videos/play/play_screen_video.mp4': playHub,
    'assets/videos/play/football/bao_not_playing_football_video.mp4':
        footballIdle,
    'assets/videos/play/football/bao_playing_football_video.mp4':
        footballAction,
    // No tennis activity exists. The tennis swing fills Cricket's action
    // slot; the tray label stays Cricket until a real cricket clip exists.
    'assets/videos/play/cricket/bao_not_playing_cricket_video.mp4': cricketIdle,
    'assets/videos/play/cricket/bao_playing_cricket_video.mp4': cricketAction,
    // Clap is the closest rhythmic action; the hop is the closest skip.
    'assets/videos/play/dance/bao_not_doing_dance_video.mp4': danceIdle,
    'assets/videos/play/dance/bao_doing_dance_video.mp4': danceAction,
    'assets/videos/play/skipping/bao_not_doing_skipping_video.mp4':
        skippingIdle,
    'assets/videos/play/skipping/bao_doing_skipping_video.mp4': skippingAction,
  };

  /// Piku files to drop in, including slots Bao never had a clip for.
  static const plannedPikuAssets = <String>[
    genericIdle,
    nightYawning,
    morning,
    noon,
    evening,
    eatingAppleSpecial,
    sleeping,
    notFeeding,
    appleIdle,
    appleAction,
    veggiesIdle,
    veggiesAction,
    riceIdle,
    riceAction,
    playHub,
    footballIdle,
    footballAction,
    cricketIdle,
    cricketAction,
    badmintonIdle,
    badmintonAction,
    danceIdle,
    danceAction,
    skippingIdle,
    skippingAction,
  ];

  /// Bao clips that stay even after Piku's set lands (no Piku match yet).
  static const baoClipsWithoutPikuMatch = <String>[
    CharacterBgVideos.nightSleeping,
    CharacterBgVideos.cleaningFloor,
    CharacterBgVideos.cleaningShelf,
    CharacterBgVideos.makingPancakes,
    'assets/videos/wake/bao_waking_up_video.mp4',
    'assets/videos/feed/water/bao_not_drinking_water.mp4',
    'assets/videos/feed/water/bao_drinking_water.mp4',
    'assets/videos/feed/milk/bao_not_drinking_milk_video.mp4',
    'assets/videos/feed/milk/bao_drinking_milk_video.mp4',
    'assets/videos/feed/banana/bao_not_eating_banana.mp4',
    'assets/videos/feed/banana/bao_eating_banana.mp4',
    'assets/videos/feed/sandwich/bao_not_eating_sandwich.mp4',
    'assets/videos/feed/sandwich/bao_eating_sandwich.mp4',
    'assets/videos/chore/make_bed/bao_not_making_bed.mp4',
    'assets/videos/chore/make_bed/bao_making_bed.mp4',
    'assets/videos/chore/brush/bao_not_brushing_teeth.mp4',
    'assets/videos/chore/brush/bao_brushing_teeth.mp4',
    'assets/videos/chore/wash_face/bao_not_washing_his_face.mp4',
    'assets/videos/chore/wash_face/bao_washing_face.mp4',
    'assets/videos/chore/bath/bao_not_taking_a_bath_video.mp4',
    'assets/videos/chore/bath/bao_taking_a_bath_video.mp4',
    'assets/videos/chore/getting_dressed/bao_not_getting_dressed.mp4',
    'assets/videos/chore/getting_dressed/bao_getting_dressed.mp4',
    'assets/videos/chore/getting_dressed/bao_getting_dressed_not_wearing_tie.mp4',
    'assets/videos/chore/getting_dressed/bao_getting_dressed_wearing_tie.mp4',
    'assets/videos/chore/wear_shoe/bao_not_wearing_shoe.mp4',
    'assets/videos/chore/wear_shoe/bao_wearing_shoe_video.mp4',
    'assets/videos/chore/wear_shoe/bao_has_worn_shoe_loop_video.mp4',
    'assets/videos/chore/wear_shoe/bao_taking_bag_after_wearing_shoe.mp4',
    'assets/videos/chore/comb_hair/bao_not_coming_hair.mp4',
    'assets/videos/chore/comb_hair/bao_combing_hair.mp4',
    'assets/videos/play/yoga/bao_not_doing_yoga_video.mp4',
    'assets/videos/play/yoga/bao_doing_yoga_video.mp4',
    'assets/videos/learn/alphabets/Bao_speaking_alphabet_AtoD.mp4',
    'assets/videos/learn/alphabets/Bao_speaking_alphabet_EtoH.mp4',
    'assets/videos/learn/alphabets/Bao_speaking_alphabet_ItoL.mp4',
    'assets/videos/learn/alphabets/Bao_speaking_alphabet_MtoP.mp4',
    'assets/videos/learn/alphabets/Bao_speaking_alphabet_QtoT.mp4',
    'assets/videos/learn/alphabets/Bao_speaking_alphabet_UtoX.mp4',
    'assets/videos/learn/alphabets/Bao_speaking_alphabet_YtoZ.mp4',
    'assets/videos/learn/numbers/numbers_from_1to5.mp4',
    'assets/videos/learn/numbers/numbers_from_6to10.mp4',
    'assets/videos/learn/numbers/numbers_from_11to15.mp4',
    'assets/videos/learn/numbers/numbers_from_16to20.mp4',
  ];

  /// Active character from `?character=`, defaulting to the unlocked lead.
  static CharacterId idOf(BuildContext context) {
    try {
      final name = GoRouterState.of(context).uri.queryParameters['character'];
      for (final id in CharacterId.values) {
        if (id.name == name) return id;
      }
    } catch (_) {
      // Splash and tests are not inside a GoRouter page.
    }
    return CharacterId.piku;
  }

  /// Keeps [path] and adds `character` so child screens resolve the same lead.
  static String withCharacter(BuildContext context, String path) {
    final uri = Uri.parse(path);
    return uri
        .replace(
          queryParameters: {
            ...uri.queryParameters,
            'character': idOf(context).name,
          },
        )
        .toString();
  }

  /// Clip to play for [id]. Piku uses a planned override once her files are
  /// bundled; everyone else, and Piku until then, keeps [baoAsset].
  static String clip(CharacterId id, String baoAsset) {
    if (id != CharacterId.piku || !pikuClipsBundled) return baoAsset;
    return plannedOverrides[baoAsset] ?? baoAsset;
  }

  /// No Piku celebration clip yet, so every character keeps Bao's still.
  /// The future file is [celebration].
  static String? celebrationVideo(CharacterId id) {
    if (id == CharacterId.piku) return null;
    return null;
  }
}
