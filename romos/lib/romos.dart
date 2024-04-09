import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:romos/actors.dart';
import 'package:romos/level.dart';
import 'package:flutter/widgets.dart';

class Romos extends FlameGame with HasKeyboardHandlerComponents
{
  @override
  Color backgroundColor() => const Color.fromARGB(255, 36, 36, 36);
  @override
  late final CameraComponent camera = CameraComponent();
  Player player = Player(character: 'Ghost');
  @override
  

  @override
  Future<void> onLoad() async
  {
    await images.loadAllImages();

    final world = Level(levelName: 'Level-2', player: player);

    camera = CameraComponent.withFixedResolution(world: world, width: 2560, height: 1920);
    camera.viewfinder.anchor = Anchor.topLeft;

    add(camera);
    add(world);
    
    return super.onLoad();
  }

  //Camera debug
  // @override
  // void render(Canvas canvas) 
  // {
  //   super.render(canvas); // Сначала рендерим все компоненты игры.

  //   // Теперь рендерим рамку вьюпорта для отладки.
  // final rectPaint = Paint()
  //   ..color = Color(0xFFFF00FF) // Ярко-розовый цвет.
  //   ..style = PaintingStyle.stroke // Рисуем только контур.
  //   ..strokeWidth = 4.0; // Толщина линии.
  // final viewportRect = Rect.fromLTWH(
  //   0, // X координата левого верхнего угла.
  //   0, // Y координата левого верхнего угла.
  //   camera.viewport.size.x, // Ширина рамки равна ширине вьюпорта.
  //   camera.viewport.size.y, // Высота рамки равна высоте вьюпорта.
  // );
  // canvas.drawRect(viewportRect, rectPaint);
  // }
}