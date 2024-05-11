import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:romos/custom_hitbox.dart';
import 'package:romos/romos.dart';

class Stone extends SpriteComponent with HasGameRef<Romos>
{
  final String stone;
  Stone({this.stone = 'Stone', position, size}) : super(position: position, size: size);

  final hitbox = CustomHitbox(offsetX: 7, offsetY: 10, width: 34, height: 34);

  @override
  FutureOr<void> onLoad() async
  {
    debugMode = true;
    add(RectangleHitbox(position: Vector2(hitbox.offsetX, hitbox.offsetY), size: Vector2(hitbox.width, hitbox.height), collisionType: CollisionType.passive));
    priority = 0;
    sprite = await Sprite.load("Items/$stone.png");
    size = Vector2.all(32);
    size.scale(1.5);
    final stoneImage = SpriteComponent(size: size, sprite: sprite);
    add(stoneImage);
    return super.onLoad();
  }

  void collidingWithPlayer()
  {
    removeFromParent();
    //print('You picked a stone');
  }
}