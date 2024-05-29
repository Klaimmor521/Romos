import 'package:flutter/material.dart';
import 'package:romos/romos.dart';

class EndDialog extends StatelessWidget 
{
  final Romos gameRef;

  const EndDialog({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return AlertDialog(
      title: const Text("Game Over", style: TextStyle(fontSize: 30, color: Colors.white)),
      backgroundColor: const Color.fromARGB(71, 44, 44, 44), //Цвет фона диалогового окна
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text("You have reached all levels! What do you wanna do next?", style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(height: 20), //Добавляет пространство между текстом и первой кнопкой
          ElevatedButton
          (
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
              backgroundColor: const Color.fromARGB(255, 33, 175, 11),
            ),
            onPressed: () 
            {
              Navigator.pop(context);
              gameRef.resetGame(); //Перезапускаем игру
            },
            child: const Text("Reset Game")
          ),
          const SizedBox(height: 10), //Добавляет пространство между кнопками
          ElevatedButton
          (
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255), //Текст
              backgroundColor: const Color.fromARGB(255, 182, 14, 14), //Кнопка
            ),
            onPressed: () 
            {
              Navigator.pop(context); //Закрываем модальное окно
              gameRef.exitGame(); //Выходим из игры
            },
            child: const Text("Exit")
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel', style: TextStyle(color: Color.fromARGB(255, 216, 10, 10))), 
          onPressed: () 
          {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}