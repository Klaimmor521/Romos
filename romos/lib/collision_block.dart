import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent
{
  bool isWalls;
  CollisionBlock({position, size, this.isWalls = false,}) : super(position: position, size: size) {debugMode = true;}
}