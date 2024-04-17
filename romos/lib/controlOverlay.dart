import 'package:flutter/material.dart';
import 'package:romos/actors.dart';
import 'package:romos/romos.dart';


class GameControlsOverlay extends StatelessWidget 
{
  final Romos gameRef;

  GameControlsOverlay({required this.gameRef});

  @override
  Widget build(BuildContext context) 
  {
    return Column
    (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>
      [
        button('assets/images/HUD/ButtonUp.png', () => gameRef.player.playerDirection = PlayerDirection.up),
        Row
        (
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>
          [
            button('assets/images/HUD/ButtonLeft.png', () => gameRef.player.playerDirection = PlayerDirection.left),
            SizedBox(width: 20),
            button('assets/images/HUD/ButtonRight.png', () => gameRef.player.playerDirection = PlayerDirection.right),
          ],
        ),
        button('assets/images/HUD/ButtonDown.png', () => gameRef.player.playerDirection = PlayerDirection.down)
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
        padding: EdgeInsets.zero, //Убираем стандартный padding
        minimumSize: Size(64, 64), //Mинимальный размер кнопки
      ),
      child: Image.asset(assetPath),
    );
  }
}