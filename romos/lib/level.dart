import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:romos/actors.dart';

class Level extends World
{
  final String levelName;
  Level({required this.levelName});
  late TiledComponent level;

  @override
  Future<void> onLoad() async
  {
    final level = await TiledComponent.load('$levelName.tmx', Vector2.all(64));
    //Debug for vector
    //level.debugMode = true; 
    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoint');
    for(final spawnPoint in spawnPointsLayer!.objects)
    {
      switch (spawnPoint.class_)
      {
        case 'Player':
          final player = Player(character: 'Ghost', position: Vector2(spawnPoint.x, spawnPoint.y));
          add(player);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}