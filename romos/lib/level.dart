import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:romos/actors.dart';
import 'package:romos/collision_block.dart';

class Level extends World
{
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];

  @override
  Future<void> onLoad() async
  {
    final level = await TiledComponent.load('$levelName.tmx', Vector2.all(64));
    //Debug for vector
    //level.debugMode = true; 
    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoint');
    if(spawnPointsLayer != null)
    {
      for (final spawnPoint in spawnPointsLayer!.objects)
      {
        switch (spawnPoint.class_)
        {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          default:
        }
      }
    }
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>("Collisions");
    if(collisionsLayer != null)
    {
      for(final collision in collisionsLayer.objects)
      {
        switch (collision.class_) 
        {
          case 'Walls':
            final walls = CollisionBlock(position: Vector2(collision.x, collision.y), size: Vector2(collision.width, collision.height), isWalls: true,);
            collisionBlocks.add(walls);
            add(walls);
            break;
          default:
        }
      }
    }
    player.collisionBlocks = collisionBlocks;
    return super.onLoad();
  }
}