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
| `piku-cricket-idle` | `assets/videos/play/cricket/piku_not_playing_cricket_video.mp4` | Cricket idle |
| `piku-cricket-action` | `assets/videos/play/cricket/piku_playing_cricket_video.mp4` | Cricket action |
| `piku-sports-idle-loop` | `assets/videos/play/badminton/piku_not_playing_badminton_video.mp4` | Badminton idle |
| `piku-sports-badminton-loop` | `assets/videos/play/badminton/piku_playing_badminton_video.mp4` | Badminton action |
| `piku-hockey-idle` | `assets/videos/play/hockey/piku_not_playing_hockey_video.mp4` | Hockey idle (no Bao clip) |
| `piku-hockey-action` | `assets/videos/play/hockey/piku_playing_hockey_video.mp4` | Hockey action (no Bao clip) |
| `piku-basketball-idle` | `assets/videos/play/basketball/piku_not_playing_basketball_video.mp4` | Basketball idle (no Bao clip) |
| `piku-basketball-action` | `assets/videos/play/basketball/piku_playing_basketball_video.mp4` | Basketball action (no Bao clip) |
| `piku-idle-loop` | `assets/videos/play/dance/piku_not_doing_dance_video.mp4` | Dance idle |
| `piku-clap-loop` | `assets/videos/play/dance/piku_doing_dance_video.mp4` | Dance action |
| `piku-idle-loop` | `assets/videos/play/skipping/piku_not_doing_skipping_video.mp4` | Skipping idle |
| `piku-jump-loop` | `assets/videos/play/skipping/piku_doing_skipping_video.mp4` | Skipping action |
| `piku-yoga-idle` | `assets/videos/play/yoga/piku_not_doing_yoga_video.mp4` | Yoga idle |
| `piku-yoga-action` | `assets/videos/play/yoga/piku_doing_yoga_video.mp4` | Yoga action |
| `piku-coloring-idle` | `assets/videos/play/coloring/piku_not_doing_coloring_video.mp4` | Coloring idle (no Bao clip) |
| `piku-coloring-action` | `assets/videos/play/coloring/piku_doing_coloring_video.mp4` | Coloring action (no Bao clip) |
| `piku-puzzle-idle` | `assets/videos/play/puzzle/piku_not_doing_puzzle_video.mp4` | Puzzle idle (no Bao clip) |
| `piku-puzzle-action` | `assets/videos/play/puzzle/piku_doing_puzzle_video.mp4` | Puzzle action (no Bao clip) |

## Still Bao

These slots have no Piku clip. They keep Bao's file.

- Celebration still: `assets/images/bao_reward_celebrate.png`
- Night sleeping background (midnight–6am), cleaning floor, cleaning shelf, making pancakes
- Wake-up sit-up: `assets/videos/wake/bao_waking_up_video.mp4`
- Water and milk, idle and action
- Banana and sandwich, idle and action
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

School → Morning Routine plays 12 steps. Each step shows an idle loop (or a still, when the clip is not ready) and one action button. The action plays once, then the same reward card as Numbers (3 stars and 1 magic bean). Next moves on. Replay returns to that step's idle. Apply soap, Bathing, Drying with towel, and Hair dry loop their action videos (`RoutineStep.loopAction`) from the tap until Next. The reward card still opens after the first play-through, with Next and Replay on top of the loop. Next moves on and stops that video. After step 12's reward, a full-screen celebration uses that same reward again. Back leaves without marking the lesson done.

Videos live in `assets/videos/routine/`. Placeholder stills live in `assets/images/routine/`. To swap a still for a finished clip, add the mp4 and flip that row's kind and path in `MorningRoutine.steps`.

Two placeholders (no mp4 yet):

| Step | Missing clip | Stand-in shown now | Drop-in filename |
| --- | --- | --- | --- |
| 2 Brushing | action | `piku-routine-02-brushing-after.jpg` | `piku-routine-02-brushing-action.mp4` |
| 11 Getting dressed | idle | `piku-routine-11-dressed-before.jpg` | `piku-routine-11-dressed-idle.mp4` |

Apply soap, Bathing, Drying with towel, and Hair dry keep looping their action mp4s after the first play. Flossing and cleaning hands use idle and action mp4s, the same way waking, face, and hair wash do. A missing action still stays on screen for 2.5 seconds, then the reward card. The other 22 clips are real mp4s.

## Go to School

School → Go to School plays 5 steps after the morning routine: school dress, tie, school shoes, school bag, then leave for school. The screen matches Morning Routine: idle, one action button, action once, the same reward card, Next, Replay, then a finale after the last reward.

Clips live in `assets/videos/school-routine/`. Placeholder stills live in `assets/images/school-routine/`. Flip a row in `GoToSchool.steps` from image to video when a missing mp4 is added.

| Step | Idle | Action |
| --- | --- | --- |
| 1 School dress | `school-01-dress-idle.mp4` | `school-01-dress-action.mp4` |
| 2 Tie | `school-02-tie-idle.mp4` | `school-02-tie-action.mp4` |
| 3 School shoes | `piku-school-03-shoes-before.jpg` | `school-03-shoes-action.mp4` |
| 4 School bag | `school-04-bag-idle.mp4` | `piku-school-04-bag-after.jpg` for 2.5 seconds |
| 5 Leave for school | `school-05-leave-idle.mp4` | `piku-school-05-leave-after.jpg` for 2.5 seconds |

Three placeholders remain: shoes idle, bag action, and leave action.

## Bed, toys, lunch, pet, and flower

These five School lessons use the same player as Morning Routine. Videos live in `assets/videos/<lesson>-routine/` and use the school-routine names (`lesson-NN-step-idle.mp4`, `lesson-NN-step-action.mp4`). The idle mp4s are seamless loops of about 10.3 seconds (forward, then reversed, so the first frame matches the last). The player loops an idle video until the action button, the same way Morning Routine does. An action video plays once. A still action stays up for 2.5 seconds, then the reward card. The other rows stay JPEG placeholders in `assets/images/<lesson>-routine/`.

### Get Ready for Bed

`/learn/get-ready-for-bed`.

| Step | Idle | Action |
| --- | --- | --- |
| 1 Pajamas | `piku-bed-01-pajamas-before.jpg` | `piku-bed-01-pajamas-after.jpg` |
| 2 Brush teeth | `piku-bed-02-brush-teeth-before.jpg` | `piku-bed-02-brush-teeth-after.jpg` |
| 3 Wash face | `piku-bed-03-wash-face-before.jpg` | `piku-bed-03-wash-face-after.jpg` |
| 4 Get in bed | `bed-04-get-in-bed-idle.mp4` | `bed-04-get-in-bed-action.mp4` |
| 5 Lights off | `piku-bed-05-lights-off-before.jpg` | `piku-bed-05-lights-off-after.jpg` |

Still placeholders: pajamas, brush teeth, wash face, and lights off (idle and action).

### Clean Up Toys

`/learn/clean-up-toys`.

| Step | Idle | Action |
| --- | --- | --- |
| 1 Pick up | `toys-01-pick-up-idle.mp4` | `piku-toys-01-pick-up-after.jpg` |
| 2 Sort | `toys-02-sort-idle.mp4` | `piku-toys-02-sort-after.jpg` |
| 3 Put in boxes | `toys-03-put-in-boxes-idle.mp4` | `piku-toys-03-put-in-boxes-after.jpg` |
| 4 Shelf | `toys-04-shelf-idle.mp4` | `piku-toys-04-shelf-after.jpg` |
| 5 Tidy room | `toys-05-tidy-room-idle.mp4` | `piku-toys-05-tidy-room-after.jpg` |

Still placeholders: every action (pick up, sort, put in boxes, shelf, tidy room).

### Pack Lunch

`/learn/pack-lunch`.

| Step | Idle | Action |
| --- | --- | --- |
| 1 Lunchbox | `piku-lunch-01-lunchbox-before.jpg` | `piku-lunch-01-lunchbox-after.jpg` |
| 2 Sandwich | `lunch-02-sandwich-idle.mp4` | `piku-lunch-02-sandwich-after.jpg` |
| 3 Fruit | `lunch-03-fruit-idle.mp4` | `piku-lunch-03-fruit-after.jpg` |
| 4 Water | `piku-lunch-04-water-before.jpg` | `piku-lunch-04-water-after.jpg` |
| 5 Close pack | `piku-lunch-05-close-pack-before.jpg` | `piku-lunch-05-close-pack-after.jpg` |

Still placeholders: lunchbox and water and close pack (idle and action), plus sandwich and fruit actions.

### Feed a Pet

`/learn/feed-a-pet`.

| Step | Idle | Action |
| --- | --- | --- |
| 1 Bowl | `pet-01-bowl-idle.mp4` | `piku-pet-01-bowl-after.jpg` |
| 2 Scoop | `pet-02-scoop-idle.mp4` | `piku-pet-02-scoop-after.jpg` |
| 3 Place | `pet-03-place-idle.mp4` | `piku-pet-03-place-after.jpg` |
| 4 Water | `pet-04-water-idle.mp4` | `piku-pet-04-water-after.jpg` |
| 5 Clean up | `piku-pet-05-clean-up-before.jpg` | `piku-pet-05-clean-up-after.jpg` |

Still placeholders: every action, and the clean-up idle.

### Plant a Flower

`/learn/plant-a-flower`.

| Step | Idle | Action |
| --- | --- | --- |
| 1 Pot | `flower-01-pot-idle.mp4` | `piku-flower-01-pot-after.jpg` |
| 2 Soil | `flower-02-soil-idle.mp4` | `piku-flower-02-soil-after.jpg` |
| 3 Seed | `piku-flower-03-seed-before.jpg` | `piku-flower-03-seed-after.jpg` |
| 4 Water | `flower-04-water-idle.mp4` | `piku-flower-04-water-after.jpg` |
| 5 Sunlight | `flower-05-sunlight-idle.mp4` | `piku-flower-05-sunlight-after.jpg` |

Still placeholders: seed idle, and every action (pot, soil, seed, water, sunlight). The pot, soil, water, and sunlight before JPEGs are the original stills, kept beside the idle videos.
