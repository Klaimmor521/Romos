import 'package:flutter/material.dart';
import 'package:romos/player.dart';
import 'package:romos/romos.dart';

class GameControlsOverlay extends StatelessWidget 
{
  final Romos gameRef;
  final String up = 'assets/images/HUD/ButtonUp.png';
  final String down = 'assets/images/HUD/ButtonDown.png';
  final String left = 'assets/images/HUD/ButtonLeft.png';
  final String right = 'assets/images/HUD/ButtonRight.png';

  const GameControlsOverlay({super.key, required this.gameRef});

  // Используем здесь теперь Stack(контейнер) чтобы были слои
  @override
  Widget build(BuildContext context)
  {
    return Stack(
      children: 
      [
        Align
        (
          alignment: Alignment.bottomRight,
          child: Padding
          (
            padding: const EdgeInsets.only(left: 60.0, bottom: 50.0), //Отступ
            child: Container
            (
              decoration: BoxDecoration
              (
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(20),

              child: Column
              (
                mainAxisSize: MainAxisSize.min,
                children: <Widget>
                [
                  Transform.translate // Сдвиг для кнопки
                  (
                    offset: const Offset(0, 15),
                    child: button(up, () => gameRef.player.playerDirection = PlayerDirection.up),
                  ),
                  Row
                  (
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>
                    [
                      button(left, () => gameRef.player.playerDirection = PlayerDirection.left),
                      const SizedBox(width: 20), // Отступ между кнопками
                      button(right, () => gameRef.player.playerDirection = PlayerDirection.right),
                    ],
                  ),
                  //Кнопка вниз ниже всех
                  Transform.translate(
                    offset: const Offset(0, -15),
                    child: button(down, () => gameRef.player.playerDirection = PlayerDirection.down),
                  ),
                ],
              ),
            ),
          ),
        ),

        Align
        (
          alignment: Alignment.topLeft,
          child: Padding
          (
            padding: const EdgeInsets.only(top: 20, left: 20),

            child: ValueListenableBuilder<int>(
              valueListenable: gameRef.player.collectedStones,
              builder: (context, count, child)
              {
                return Text(
                  'Stones: $count / 16',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(blurRadius: 4, color: Colors.black, offset: Offset(2, 2)),
                    ]
                  ),
                );
              }
            )
          )
        )
      ],
    );
  }

  Widget button(String assetPath, VoidCallback onPressed) 
  {
    return TextButton
    (
      onPressed: onPressed,
      style: TextButton.styleFrom
      (
        padding: EdgeInsets.zero, 
        minimumSize: const Size(64, 64), //Mинимальный размер кнопки
      ),
      child: Image.asset
      (
        assetPath,
        color: Colors.white.withOpacity(0.8),
        colorBlendMode: BlendMode.modulate, 
      ),
    );
  }
}