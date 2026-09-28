# Piku & Friends

**Tiny Think – Piku & Friends** by Klay Kandy. A sibling of [bao_and_friends](https://github.com/TheSinghPranjal/bao_and_friends), rebranded the same way as [poko_and_friends](https://github.com/TheSinghPranjal/poko_and_friends).

The Flutter tree matches Bao: models, go_router, screens, stores, theme, and the activity video state machines (idle loop, floating bubble tap, one-shot action, next idle, reward). Piku is the unlocked lead. She is a cheerful, curious, kind little rabbit (she/her) who loves to learn, explore, and play. The family order is Bao, Piku, Po, Koko, Momo, Dodo. Bao and the rest are coming soon. The carousel opens on Piku.

Where a Piku clip exists, her screens play it (`lib/models/character_media.dart`). Bao's files stay registered and still play for Bao. Slots with no Piku clip, including the reward celebration, keep Bao's media. The slot map is in [docs/piku_media.md](docs/piku_media.md).

## Run locally

```bash
cd ~/StudioProjects/piku_rabbit
git checkout main && git pull origin main && flutter pub get && flutter run
```

## Identity

| | Value |
| --- | --- |
| Package | `piku_rabbit` |
| Display name | Piku & Friends |
| Android applicationId | `com.lazy_bear_club.pikurabbit` |
| iOS / macOS bundle id | `com.lazybearclub.pikurabbit` |
| Play listing URL in force-update | `https://play.google.com/store/apps/details?id=com.lazy_bear_club.pikurabbit` |

## Firebase (left for a human)

`lib/firebase_options.dart`, `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`, and `firebase.json` are placeholders. They are not Bao's project and they are not real secrets. The app still boots: Android `Firebase.initializeApp` is inside try/catch, and force-update is skipped when init fails.

1. Create a Firebase project (suggested id `piku-and-friends`).
2. Register Android `com.lazy_bear_club.pikurabbit` and iOS `com.lazybearclub.pikurabbit`.
3. Run FlutterFire (`flutterfire configure` with those ids) or drop in the downloaded plist/json and replace `lib/firebase_options.dart`.
4. Add Remote Config keys used by Bao: `force_update` (bool), `minimum_android_version` (string), `latest_android_version` (string).
5. Add `android/key.properties` (gitignored) before a Play release build. The Gradle release signing block matches Bao and no-ops until that file exists.
