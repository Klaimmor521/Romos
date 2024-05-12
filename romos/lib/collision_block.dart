import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent
{
  bool isWalls;
  CollisionBlock({super.position, super.size, this.isWalls = false,});
}