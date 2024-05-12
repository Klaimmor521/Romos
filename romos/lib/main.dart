import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:romos/control_overlay.dart';
import 'package:romos/romos.dart';

void main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  Romos game = Romos();
  
  runApp
  (
    MaterialApp(
      home: Scaffold
      (
        body: GameWidget<Romos>
        (
          game: kDebugMode ? Romos() : game,
          overlayBuilderMap: 
          {
            'controls': (BuildContext context, Romos game) => GameControlsOverlay(gameRef: game),
          },
          initialActiveOverlays: const ['controls']
        ),
      ),
    ),
  );
}