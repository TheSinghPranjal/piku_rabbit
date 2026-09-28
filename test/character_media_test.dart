import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/character.dart';
import 'package:piku_rabbit/models/character_media.dart';
import 'package:piku_rabbit/models/feed_foods.dart';
import 'package:piku_rabbit/models/play_games.dart';

void main() {
  test('planned Piku clips mirror Poko naming and are not bundled yet', () {
    expect(CharacterMedia.pikuClipsBundled, isFalse);
    expect(
      CharacterMedia.plannedPikuAssets.toSet().length,
      CharacterMedia.plannedPikuAssets.length,
    );
    for (final path in CharacterMedia.plannedPikuAssets) {
      expect(path.split('/').last.startsWith('piku_'), isTrue, reason: path);
      expect(path.contains('poko'), isFalse, reason: path);
      expect(File(path).existsSync(), isFalse, reason: path);
    }
    expect(
      CharacterMedia.plannedOverrides.values.toSet(),
      isNot(contains(CharacterMedia.celebration)),
    );
    expect(
      CharacterMedia.plannedPikuAssets,
      containsAll(CharacterMedia.plannedOverrides.values),
    );
  });

  test('Piku plays Bao placeholders until her clips are bundled', () {
    const apple = 'assets/videos/feed/apple/bao_eating_apple.mp4';
    expect(CharacterMedia.clip(CharacterId.piku, apple), apple);
    expect(CharacterMedia.clip(CharacterId.bao, apple), apple);
    expect(CharacterMedia.clip(CharacterId.po, apple), apple);
    expect(CharacterMedia.celebrationVideo(CharacterId.piku), isNull);
    expect(CharacterMedia.celebrationVideo(CharacterId.bao), isNull);

    final placeholders = [
      ...CharacterMedia.plannedOverrides.keys,
      ...CharacterMedia.baoClipsWithoutPikuMatch,
    ];
    for (final path in placeholders) {
      expect(File(path).existsSync(), isTrue, reason: path);
      expect(CharacterMedia.clip(CharacterId.piku, path), path);
    }
  });

  test('feed and play stay on Bao media until Piku clips land', () {
    final apple = FeedFoods.resolve('apple', CharacterId.piku);
    expect(apple.idleVideoAsset, contains('bao_not_eating_apple'));
    expect(apple.actionVideoAsset, contains('bao_eating_apple'));

    final football = PlayGames.byId('football')!;
    expect(
      PlayGames.resolve(football, CharacterId.piku).actionVideoAsset,
      football.actionVideoAsset,
    );
    expect(
      PlayGames.resolve(football, CharacterId.bao).actionVideoAsset,
      football.actionVideoAsset,
    );

    final badminton = PlayGames.byId('badminton')!;
    expect(badminton.hasVideos, isFalse);
    expect(PlayGames.resolve(badminton, CharacterId.piku).hasVideos, isFalse);
  });
}
