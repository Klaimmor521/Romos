import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:romos/romos.dart';

class Stone extends SpriteComponent with HasGameRef<Romos>
{
  final String stone;
  Stone({this.stone = 'Stone', position, size}) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async
  {
    priority = -1;
    sprite = await Sprite.load("Items/$stone.png");
    size = Vector2.all(32);
    final stoneImage = SpriteComponent(size: size, sprite: sprite);
    add(stoneImage);
    return super.onLoad();
  }
}