import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:piku_rabbit/models/character.dart';
import 'package:piku_rabbit/screens/character_selection/character_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('picker lists only Piku and the shared roster stays complete', () {
    expect(selectionScreenCharacters().map((c) => c.id), [CharacterId.piku]);
    expect(selectionScreenCharacters().single.isUnlocked, isTrue);
    expect(selectionScreenCharacters().single.name, 'Piku');

    expect(familyCharacters.map((c) => c.id), [
      CharacterId.bao,
      CharacterId.piku,
      CharacterId.po,
      CharacterId.koko,
      CharacterId.momo,
      CharacterId.dodo,
    ]);
    expect(characterById(CharacterId.bao).name, 'Bao');
    expect(characterById(CharacterId.piku).name, 'Piku');
  });

  test('picker art is registered and the old files are still on disk', () {
    expect(
      selectionCardAsset(characterById(CharacterId.piku)),
      pikuSelectionCardAsset,
    );
    expect(
      selectionCardAsset(characterById(CharacterId.bao)),
      'assets/images/characters/bao.png',
    );

    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec.contains(characterSelectBackgroundAsset), isTrue);
    expect(pubspec.contains('assets/images/characters/'), isTrue);
    expect(pubspec.contains('assets/images/character_select_bg.png'), isTrue);

    for (final path in [
      pikuSelectionCardAsset,
      characterSelectBackgroundAsset,
      'assets/images/characters/piku.png',
      'assets/images/characters/bao.png',
      'assets/images/character_select_bg.png',
    ]) {
      expect(File(path).existsSync(), isTrue, reason: path);
    }
  });

  testWidgets(
    'selection screen shows only centered Piku and Play still opens home',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final router = GoRouter(
        initialLocation: '/select',
        routes: [
          GoRoute(
            path: '/select',
            builder: (context, state) => const CharacterSelectionScreen(),
          ),
          GoRoute(
            path: '/home/:characterId',
            builder: (context, state) =>
                Text('opened-${state.pathParameters['characterId']}'),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump();

      expect(find.text('Piku'), findsOneWidget);
      expect(find.text('Unlocked'), findsOneWidget);
      expect(find.text('Choose Your'), findsOneWidget);
      expect(find.text('Family Member'), findsOneWidget);
      expect(find.bySemanticsLabel('Back'), findsOneWidget);
      expect(find.text('Play'), findsOneWidget);

      for (final gone in ['Bao', 'Po', 'Koko', 'Momo', 'Dodo', 'Coming Soon']) {
        expect(find.text(gone), findsNothing, reason: gone);
      }
      expect(find.bySemanticsLabel('Flip carousel'), findsNothing);
      expect(find.byKey(const Key('character-selection-dots')), findsNothing);

      final assets = tester
          .widgetList<Image>(find.byType(Image))
          .map((image) => image.image)
          .whereType<AssetImage>()
          .map((image) => image.assetName)
          .toList();
      expect(assets, contains(characterSelectBackgroundAsset));
      expect(assets, contains(pikuSelectionCardAsset));
      expect(assets, isNot(contains('assets/images/character_select_bg.png')));
      expect(assets, isNot(contains('assets/images/characters/piku.png')));

      final background = tester.widget<Image>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  characterSelectBackgroundAsset,
        ),
      );
      expect(background.fit, BoxFit.cover);

      final cardCenter = tester.getCenter(find.text('Piku'));
      final screenWidth =
          tester.view.physicalSize.width / tester.view.devicePixelRatio;
      expect(cardCenter.dx, closeTo(screenWidth / 2, 24));

      await tester.tap(find.text('Play'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pump();

      expect(find.text('opened-piku'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    },
  );
}
