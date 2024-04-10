import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
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
  Future<void> onLoad() async
  {
    await images.loadAllImages();

    final world = Level(levelName: 'Level-2', player: player);

    camera = CameraComponent.withFixedResolution(world: world, width: 2560, height: 1920);
    camera.viewfinder.anchor = Anchor.topLeft;

    add(camera);
    add(world);
    addButtons();
    
    return super.onLoad();
  }
  
  void addButtons() 
  {
    final buttonSize = Vector2(64, 64);
    final buttonPadding = Vector2(10, 10);
    
    //Button Up
    final buttonUp = SpriteButtonComponent(
      priority: 10,
      button: Sprite(images.fromCache('HUD/ButtonUp.png')),
      position: Vector2(size.x / 2 - buttonSize.x / 2, size.y - buttonSize.y * 3),
      size: buttonSize,
      onPressed: () 
      {
        player.playerDirection = PlayerDirection.up;
      },
    );

    //Button Down
    final buttonDown = SpriteButtonComponent(
      priority: 10,
      button: Sprite(images.fromCache('HUD/ButtonDown.png')),
      position: Vector2(size.x / 2 - buttonSize.x / 2, size.y - buttonSize.y),
      size: buttonSize,
      onPressed: () 
      {
        player.playerDirection = PlayerDirection.down;
      },
    );

    //Button Left
    final buttonLeft = SpriteButtonComponent(
      priority: 10,
      button: Sprite(images.fromCache('HUD/ButtonLeft.png')),
      position: Vector2(size.x / 2 - buttonSize.x - buttonPadding.x, size.y - buttonSize.y * 2),
      size: buttonSize,
      onPressed: () 
      {
        player.playerDirection = PlayerDirection.right;
      },
    );

    //Button Right
    final buttonRight = SpriteButtonComponent(
      priority: 10,
      button: Sprite(images.fromCache('HUD/ButtonRight.png')),
      position: Vector2(size.x / 2 + buttonSize.x / 2 + buttonPadding.x, size.y - buttonSize.y * 2),
      size: buttonSize,
      onPressed: () 
      {
        player.playerDirection = PlayerDirection.right;
      },
    );

    add(buttonUp);
    add(buttonDown);
    add(buttonLeft);
    add(buttonRight);
  }

  //Camera debug
  // @override
  // void render(Canvas canvas) 
  // {
  //   super.render(canvas); // Сначала рендерим все компоненты игры.

  //   //Теперь рендерим рамку вьюпорта для отладки.
  // final rectPaint = Paint()
  //   ..color = Color(0xFFFF00FF) //Ярко-розовый цвет.
  //   ..style = PaintingStyle.stroke //Рисуем только контур.
  //   ..strokeWidth = 4.0; //Толщина линии.
  // final viewportRect = Rect.fromLTWH(
  //   0, //X координата левого верхнего угла.
  //   0, //Y координата левого верхнего угла.
  //   camera.viewport.size.x, //Ширина рамки равна ширине вьюпорта.
  //   camera.viewport.size.y, //Высота рамки равна высоте вьюпорта.
  // );
  // canvas.drawRect(viewportRect, rectPaint);
  // }
}