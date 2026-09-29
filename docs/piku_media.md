# Piku media

Piku's screens play her loops where a clip exists, using the same slot map as Poko. Files use the `piku_` prefix in Poko's folders. Several slots share one source loop, the same way Poko copied one file into several paths.

`CharacterMedia.pikuClipsBundled` is true. There is no celebration clip yet, so the reward card still uses Bao's still `assets/images/bao_reward_celebrate.png`. The future path is `assets/videos/reward/piku_celebration_loop.mp4`.

The character card portrait is still Bao's image at `assets/images/characters/piku.png`.

## Slot map

| Source loop | Repo path | Slot |
| --- | --- | --- |
| `piku-idle-loop` | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_bg_video.mp4` | Generic idle, Learn hub, Chores hub, Dance idle, Skipping idle |
| `piku-wave-loop` | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_morning_bg_video.mp4` | Home morning (6am–noon) |
| `piku-playroom-sunny-loop` | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_noon_bg_video.mp4` | Home noon (noon–5pm) |
| `piku-match-loop` | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_evening_bg_video.mp4` | Home evening (5pm–10pm) |
| `piku-bedroom-night-loop` | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_night_yawning_bg_video.mp4` | Home night yawning (10pm–midnight) |
| `piku-bedroom-night-loop` | `assets/videos/wake/piku_sleeping_video.mp4` | Sleeping loop and Wake Up |
| `piku-eating-idle-loop` | `assets/videos/piku_not_feeding.mp4` | Feed hub idle |
| `piku-eating-idle-loop` | `assets/videos/feed/apple/piku_not_eating_apple.mp4` | Apple idle |
| `piku-eating-apple-loop` | `assets/videos/feed/apple/piku_eating_apple.mp4` | Apple action |
| `piku-eating-apple-loop` | `assets/videos/piku_character_screen_bg_video_list/piku_character_screen_bg_eating_apple_video.mp4` | Home apple special (12:30–1:00pm) |
| `piku-eating-idle-loop` | `assets/videos/feed/veggies/piku_not_eating_veggies.mp4` | Veggies idle |
| `piku-eating-salad-loop` | `assets/videos/feed/veggies/piku_eating_veggies.mp4` | Veggies action |
| `piku-eating-idle-loop` | `assets/videos/feed/rice/piku_not_eating_rice.mp4` | Rice idle |
| `piku-eating-soup-loop` | `assets/videos/feed/rice/piku_eating_rice.mp4` | Rice action (closest bowl meal) |
| `piku-sports-idle-loop` | `assets/videos/play/piku_play_screen_video.mp4` | Play hub |
| `piku-sports-idle-loop` | `assets/videos/play/football/piku_not_playing_football_video.mp4` | Football idle |
| `piku-sports-football-loop` | `assets/videos/play/football/piku_playing_football_video.mp4` | Football action |
| `piku-sports-idle-loop` | `assets/videos/play/cricket/piku_not_playing_cricket_video.mp4` | Cricket idle |
| `piku-sports-tennis-loop` | `assets/videos/play/cricket/piku_playing_cricket_video.mp4` | Cricket action (no tennis tray item) |
| `piku-sports-idle-loop` | `assets/videos/play/badminton/piku_not_playing_badminton_video.mp4` | Badminton idle |
| `piku-sports-badminton-loop` | `assets/videos/play/badminton/piku_playing_badminton_video.mp4` | Badminton action |
| `piku-idle-loop` | `assets/videos/play/dance/piku_not_doing_dance_video.mp4` | Dance idle |
| `piku-clap-loop` | `assets/videos/play/dance/piku_doing_dance_video.mp4` | Dance action |
| `piku-idle-loop` | `assets/videos/play/skipping/piku_not_doing_skipping_video.mp4` | Skipping idle |
| `piku-jump-loop` | `assets/videos/play/skipping/piku_doing_skipping_video.mp4` | Skipping action |

## Still Bao

These slots have no Piku clip. They keep Bao's file.

- Celebration still: `assets/images/bao_reward_celebrate.png`
- Night sleeping background (midnight–6am), cleaning floor, cleaning shelf, making pancakes
- Wake-up sit-up: `assets/videos/wake/bao_waking_up_video.mp4`
- Water and milk, idle and action
- Banana and sandwich, idle and action
- Yoga idle and action
- Chores: make bed, brush teeth, wash face, bath, comb hair, get dressed (including tie beats), wear shoes (including the bag beat)
- Splash background: `assets/videos/splash_screen_bg_video.mp4`

## Alphabet lesson

School → Alphabet plays 25 voiced clips in order, in `assets/videos/learn/alphabets/` next to the numbers clips. Each file is 720×1280, H.264 + AAC, and plays with sound. Names are `piku-alphabet-X-Y.mp4` for each overlapping pair from A–B through Y–Z.

Clips before Y–Z loop until Next. `piku-alphabet-Y-Z.mp4` plays through once, then the usual reward card (the same star store and reward popup as Numbers). Back leaves without a reward. Bao's old `Bao_speaking_alphabet_*.mp4` clips are not used on this screen.

## Numbers lesson

School → Numbers plays five voiced clips in order. Each file is 720×1280, H.264 + AAC, and plays with sound. Clips 12–16 and 16–20 may be replaced later under the same filenames.

| Order | Video | Poster while it loads | Behaviour |
| --- | --- | --- | --- |
| 1 | `assets/videos/learn/numbers/piku-numbers-01-04.mp4` | `assets/images/learn/numbers/piku-school-number-01.png` | Loops until Next |
| 2 | `assets/videos/learn/numbers/piku-numbers-04-08.mp4` | `assets/images/learn/numbers/piku-school-number-04.png` | Loops until Next |
| 3 | `assets/videos/learn/numbers/piku-numbers-08-12.mp4` | `assets/images/learn/numbers/piku-school-number-08.png` | Loops until Next |
| 4 | `assets/videos/learn/numbers/piku-numbers-12-16.mp4` | `assets/images/learn/numbers/piku-school-number-12.png` | Loops until Next |
| 5 | `assets/videos/learn/numbers/piku-numbers-16-20.mp4` | `assets/images/learn/numbers/piku-school-number-16.png` | Plays through once, then the usual reward card |

`assets/images/learn/numbers/piku-school-number-20.png` is the last frame of clip 5 and shows after that play finishes, under the reward. Back leaves the lesson without a reward, same as Alphabet. Bao's old `numbers_from_*.mp4` clips are not used on this screen.
