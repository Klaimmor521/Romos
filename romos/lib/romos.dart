import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:romos/player.dart';
import 'package:romos/level.dart';
import 'package:flutter/widgets.dart';

class Romos extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection
{
  @override
  Color backgroundColor() => const Color.fromARGB(255, 36, 36, 36);
  @override
  late CameraComponent camera = CameraComponent();
  Player player = Player(character: 'Ghost');
  List<String> levelNames = ['Level-1','Level-2'];
  int currentLevelIndex = 0;

  @override
  Future<void> onLoad() async
  {
    await images.loadAllImages();

    _loadLevel();
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

  void loadNextLevel()
  {
    if(currentLevelIndex < levelNames.length - 1)
    {
      removeAll(children.toList());
      player.collectedStones = 0;
      currentLevelIndex++;
      _loadLevel();
      FlameAudio.play("Load level.wav");
    }
    else
    {
      print('Level: $currentLevelIndex');
      showEndGameDialog();
    }
  }
  
  void _loadLevel() async
  {
    Future.delayed(const Duration(seconds: 1), () 
    {
      Level world = Level(levelName: levelNames[currentLevelIndex], player: player);

      final camera = CameraComponent.withFixedResolution(world: world, width: 2560, height: 1920);
      camera.viewfinder.anchor = Anchor.center;
      camera.follow(player);
      camera.viewfinder.zoom = 2.4; //camera zoom

      addAll([camera, world]);
    });
  }

  void resetLevel()
  {
    removeAll(children.toList());
    player.collectedStones = 0;
    loadLevel(currentLevelIndex);
  }
  
  void loadLevel(int index) 
  {
    currentLevelIndex = index;
    _loadLevel();
  }

  void resetGame() 
  {
    removeAll(children.toList());
    player.collectedStones = 0;
    currentLevelIndex = 0;
    _loadLevel();
  }

  void exitGame() 
  {
    exit(0);
  }

  void showEndGameDialog()
  {
    overlays.add('EndGameMenu');
  }
}