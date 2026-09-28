# Piku media drop-in

Piku's screens still play Bao's videos and images. Drop the clips below into the same folders Poko uses, with `piku_` in place of `poko_`. Then:

1. Add each path under `flutter: assets:` in `pubspec.yaml`.
2. Set `CharacterMedia.pikuClipsBundled` to `true` in `lib/models/character_media.dart`.

Until that flag is on, the app ignores these paths and keeps the Bao file for that slot.

The character card portrait is Bao's image copied to `assets/images/characters/piku.png`. Replace that file when Piku art is ready (cream fur, pink inner ears, yellow t-shirt, blue denim overalls with a carrot patch).

## Idle

| Slot | Path |
| --- | --- |
| Generic idle | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_bg_video.mp4` |
| Morning | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_morning_bg_video.mp4` |
| Noon | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_noon_bg_video.mp4` |
| Evening | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_evening_bg_video.mp4` |
| Feed hub idle | `assets/videos/piku_not_feeding.mp4` |

## Bedroom night

| Slot | Path |
| --- | --- |
| Night yawning | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_night_yawning_bg_video.mp4` |
| Sleeping | `assets/videos/wake/piku_sleeping_video.mp4` |

## Playroom

| Slot | Path |
| --- | --- |
| Play hub | `assets/videos/play/piku_play_screen_video.mp4` |

## Sports

| Slot | Path |
| --- | --- |
| Football idle | `assets/videos/play/football/piku_not_playing_football_video.mp4` |
| Football action | `assets/videos/play/football/piku_playing_football_video.mp4` |
| Cricket idle | `assets/videos/play/cricket/piku_not_playing_cricket_video.mp4` |
| Cricket action | `assets/videos/play/cricket/piku_playing_cricket_video.mp4` |
| Badminton idle | `assets/videos/play/badminton/piku_not_playing_badminton_video.mp4` |
| Badminton action | `assets/videos/play/badminton/piku_playing_badminton_video.mp4` |
| Dance idle | `assets/videos/play/dance/piku_not_doing_dance_video.mp4` |
| Dance action | `assets/videos/play/dance/piku_doing_dance_video.mp4` |
| Skipping idle | `assets/videos/play/skipping/piku_not_doing_skipping_video.mp4` |
| Skipping action | `assets/videos/play/skipping/piku_doing_skipping_video.mp4` |

## Eating

| Slot | Path |
| --- | --- |
| Apple idle | `assets/videos/feed/apple/piku_not_eating_apple.mp4` |
| Apple action | `assets/videos/feed/apple/piku_eating_apple.mp4` |
| Veggies idle | `assets/videos/feed/veggies/piku_not_eating_veggies.mp4` |
| Veggies action | `assets/videos/feed/veggies/piku_eating_veggies.mp4` |
| Rice idle | `assets/videos/feed/rice/piku_not_eating_rice.mp4` |
| Rice action | `assets/videos/feed/rice/piku_eating_rice.mp4` |
| Eating apple (home special) | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_bg_eating_apple_video.mp4` |

## Celebration

| Slot | Path |
| --- | --- |
| Reward loop | `assets/videos/reward/piku_celebration_loop.mp4` |

## Still Bao after this set

These slots have no Piku file in Poko's set either. They keep playing Bao's clip (chores, drinks, banana, sandwich, yoga, alphabet, numbers, night-sleeping bedroom, cleaning, pancakes, and the wake-up transition).
