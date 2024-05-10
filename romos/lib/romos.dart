import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:romos/player.dart';
import 'package:romos/level.dart';
import 'package:flutter/widgets.dart';

class Romos extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection
{
  @override
  Color backgroundColor() => const Color.fromARGB(255, 36, 36, 36);
  @override
  late final CameraComponent camera = CameraComponent();
  Player player = Player(character: 'Ghost');

  @override
  Future<void> onLoad() async
  {
    await images.loadAllImages();

    final world = Level(levelName: 'Level-2', player: player);

    final camera = CameraComponent.withFixedResolution(world: world, width: 2560, height: 1920);
    camera.viewfinder.anchor = Anchor.center;
    camera.follow(player);
    camera.viewfinder.zoom = 2.4; //camera zoom

    await add(camera);
    await add(world);
    showControls();
    
    return super.onLoad();
  }

  void showControls() 
  {
    overlays.add('controls');
  }
  void hideControls() 
  {
    overlays.remove('controls');
  }
}