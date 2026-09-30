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

## Morning routine

School → Morning Routine plays 12 steps. Each step shows an idle loop (or a still, when the clip is not ready) and one action button. The action plays once, then the same reward card as Numbers (3 stars and 1 magic bean). Next moves on. Replay returns to that step's idle. After step 12's reward, a full-screen celebration uses that same reward again. Back leaves without marking the lesson done.

Videos live in `assets/videos/routine/`. Placeholder stills live in `assets/images/routine/`. To swap a still for a finished clip, add the mp4 and flip that row's kind and path in `MorningRoutine.steps`.

Nine placeholders (no mp4 yet):

| Step | Missing clip | Stand-in shown now | Drop-in filename |
| --- | --- | --- | --- |
| 2 Brushing | action | `piku-routine-02-brushing-after.jpg` | `piku-routine-02-brushing-action.mp4` |
| 3 Flossing | action | `piku-routine-03-flossing-after.jpg` | `piku-routine-03-flossing-action.mp4` |
| 4 Cleaning hands | idle | `piku-routine-04-hands-before.jpg` | `piku-routine-04-hands-idle.mp4` |
| 4 Cleaning hands | action | `piku-routine-04-hands-after.jpg` | `piku-routine-04-hands-action.mp4` |
| 8 Apply soap | action | `piku-routine-08-soap-after.jpg` | `piku-routine-08-soap-action.mp4` |
| 9 Bathing | action | `piku-routine-09-bathing-after.jpg` | `piku-routine-09-bathing-action.mp4` |
| 10 Drying with towel | action | `piku-routine-10-towel-after.jpg` | `piku-routine-10-towel-action.mp4` |
| 11 Getting dressed | idle | `piku-routine-11-dressed-before.jpg` | `piku-routine-11-dressed-idle.mp4` |
| 12 Hair dry | action | `piku-routine-12-hairdry-after.jpg` | `piku-routine-12-hairdry-action.mp4` |

A missing action still stays on screen for 2.5 seconds, then the reward card. The other 15 clips are real mp4s.

## Go to School

School → Go to School plays 5 steps after the morning routine: school dress, tie, school shoes, school bag, then leave for school. The screen matches Morning Routine: idle, one action button, action once, the same reward card, Next, Replay, then a finale after the last reward.

Stills are 720×1280 JPEGs in `assets/images/school-routine/`. Finished clips belong in `assets/videos/school-routine/`. Flip a row in `GoToSchool.steps` from image to video when the mp4 is added.

Until those clips land, every row is a still. These seven are the ones to replace:

| Step | Clip | Stand-in now | Drop-in filename |
| --- | --- | --- | --- |
| 1 School dress | idle | `piku-school-01-dress-before.jpg` | `school-01-dress-idle.mp4` |
| 1 School dress | action | `piku-school-01-dress-after.jpg` | `school-01-dress-action.mp4` |
| 2 Tie | idle | `piku-school-02-tie-before.jpg` | `school-02-tie-idle.mp4` |
| 2 Tie | action | `piku-school-02-tie-after.jpg` | `school-02-tie-action.mp4` |
| 3 School shoes | action | `piku-school-03-shoes-after.jpg` | `school-03-shoes-action.mp4` |
| 4 School bag | idle | `piku-school-04-bag-before.jpg` | `school-04-bag-idle.mp4` |
| 5 Leave for school | idle | `piku-school-05-leave-before.jpg` | `school-05-leave-idle.mp4` |

These three stay stills: shoes idle (`piku-school-03-shoes-before.jpg`), bag action (`piku-school-04-bag-after.jpg`, 2.5 seconds), leave action (`piku-school-05-leave-after.jpg`, 2.5 seconds).
