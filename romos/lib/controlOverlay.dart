import 'package:flutter/material.dart';
import 'package:romos/player.dart';
import 'package:romos/romos.dart';

class GameControlsOverlay extends StatelessWidget 
{
  final Romos gameRef;
  String up = 'assets/images/HUD/ButtonUp.png';
  String down = 'assets/images/HUD/ButtonDown.png';
  String left = 'assets/images/HUD/ButtonLeft.png';
  String right = 'assets/images/HUD/ButtonRight.png';

  GameControlsOverlay({required this.gameRef});

  @override
 Widget build(BuildContext context) 
 {
    return Align
    (
      alignment: Alignment.bottomLeft,
      child: Padding
      (
        padding: const EdgeInsets.only(left: 40.0, bottom: 40.0), //Отступ
        child: Column
        (
          mainAxisSize: MainAxisSize.min,
          children: <Widget>
          [
            //Кнопка "вверх" выше всех
            button(up, () => gameRef.player.playerDirection = PlayerDirection.up),
            //const SizedBox(height: 0),
            //Горизонтальное расположение кнопок влево и вправо
            Row
            (
              mainAxisSize: MainAxisSize.min,
              children: <Widget>
              [
                button(left, () => gameRef.player.playerDirection = PlayerDirection.left),
                const SizedBox(width: 10), //Отступ между кнопками
                button(right, () => gameRef.player.playerDirection = PlayerDirection.right),
              ],
            ),
            //const SizedBox(height: 0),
            //Кнопка вниз ниже всех
            button(down, () => gameRef.player.playerDirection = PlayerDirection.down),
          ],
        ),
      ),
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
      child: Image.asset(assetPath),
    );
  }
}