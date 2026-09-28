import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:piku_rabbit/models/character.dart';
import 'package:piku_rabbit/models/character_media.dart';
import 'package:piku_rabbit/models/feed_foods.dart';
import 'package:piku_rabbit/models/play_games.dart';

void main() {
  test('every bundled Piku clip is a registered file', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(CharacterMedia.pikuClipsBundled, isTrue);
    expect(
      CharacterMedia.plannedPikuAssets.toSet().length,
      CharacterMedia.plannedPikuAssets.length,
    );
    expect(
      CharacterMedia.plannedPikuAssets,
      containsAll(CharacterMedia.plannedOverrides.values),
    );
    for (final path in CharacterMedia.plannedPikuAssets) {
      expect(path.split('/').last.startsWith('piku_'), isTrue, reason: path);
      expect(File(path).existsSync(), isTrue, reason: path);
      expect(pubspec.contains('    - $path'), isTrue, reason: path);
    }
    expect(File(CharacterMedia.celebration).existsSync(), isFalse);
    expect(pubspec.contains(CharacterMedia.celebration), isFalse);
  });

  test('Piku swaps matching slots and Bao keeps his own files', () {
    const apple = 'assets/videos/feed/apple/bao_eating_apple.mp4';
    expect(CharacterMedia.clip(CharacterId.bao, apple), apple);
    expect(CharacterMedia.clip(CharacterId.po, apple), apple);
    expect(
      CharacterMedia.clip(CharacterId.piku, apple),
      CharacterMedia.appleAction,
    );

    for (final fallback in CharacterMedia.baoClipsWithoutPikuMatch) {
      expect(
        CharacterMedia.plannedOverrides.containsKey(fallback),
        isFalse,
        reason: fallback,
      );
      expect(CharacterMedia.clip(CharacterId.piku, fallback), fallback);
      expect(File(fallback).existsSync(), isTrue, reason: fallback);
    }

    final baoFootball = File(
      'assets/videos/play/football/bao_playing_football_video.mp4',
    ).readAsBytesSync();
    final pikuFootball = File(CharacterMedia.footballAction).readAsBytesSync();
    expect(baoFootball, isNot(equals(pikuFootball)));
  });

  test('feed and play resolve per character', () {
    final pikuApple = FeedFoods.resolve('apple', CharacterId.piku);
    expect(pikuApple.idleVideoAsset, CharacterMedia.appleIdle);
    expect(pikuApple.actionVideoAsset, CharacterMedia.appleAction);

    final baoApple = FeedFoods.resolve('apple', CharacterId.bao);
    expect(baoApple.actionVideoAsset, contains('bao_eating_apple'));

    final milk = FeedFoods.resolve('milk', CharacterId.piku);
    expect(milk.idleVideoAsset, contains('bao_not_drinking_milk'));
    expect(milk.actionVideoAsset, contains('bao_drinking_milk'));

    final rice = FeedFoods.resolve('rice', CharacterId.piku);
    expect(rice.actionVideoAsset, CharacterMedia.riceAction);

    final football = PlayGames.byId('football')!;
    expect(
      PlayGames.resolve(football, CharacterId.piku).actionVideoAsset,
      CharacterMedia.footballAction,
    );
    expect(
      PlayGames.resolve(football, CharacterId.bao).actionVideoAsset,
      football.actionVideoAsset,
    );

    final badminton = PlayGames.byId('badminton')!;
    expect(badminton.hasVideos, isFalse);
    expect(PlayGames.resolve(badminton, CharacterId.piku).hasVideos, isTrue);
    expect(PlayGames.resolve(badminton, CharacterId.bao).hasVideos, isFalse);

    final cricket = PlayGames.byId('cricket')!;
    expect(
      PlayGames.resolve(cricket, CharacterId.piku).actionVideoAsset,
      CharacterMedia.cricketAction,
    );
    expect(
      PlayGames.resolve(cricket, CharacterId.bao).idleVideoAsset,
      cricket.idleVideoAsset,
    );

    expect(CharacterMedia.celebrationVideo(CharacterId.piku), isNull);
    expect(CharacterMedia.celebrationVideo(CharacterId.bao), isNull);
  });
}
