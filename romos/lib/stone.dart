import 'dart:async';
import 'package:flame/components.dart';
import 'package:romos/romos.dart';

class Stone extends SpriteComponent with HasGameRef<Romos>
{
  final String stone;
  Stone({this.stone = 'Stone', position, size}) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async
  {
    sprite = await Sprite.load("Items/$stone.png");
    size = Vector2.all(32);
    size.scale(1.5);
    final stoneImage = SpriteComponent(size: size, sprite: sprite);
    add(stoneImage);
    return super.onLoad();
  }
}