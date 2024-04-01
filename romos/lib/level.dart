import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World
{
  late TiledComponent level;

  @override
  Future<void> onLoad() async
  {
    final level = await TiledComponent.load('Level-1.tmx', Vector2.all(64));
    //Debug for vector
    //level.debugMode = true; 
    add(level);

    return super.onLoad();
  }
}