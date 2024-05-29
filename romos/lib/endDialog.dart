import 'package:flutter/material.dart';
import 'package:romos/romos.dart';

class EndDialog extends StatelessWidget 
{
  final Romos gameRef;

  const EndDialog({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) 
  {
    return AlertDialog
    (
      title: const Text("The End", style: TextStyle(fontSize: 30, color: Colors.white)),
      backgroundColor: const Color.fromARGB(70, 30, 41, 38), //Цвет фона диалогового окна
      content: Column
      (
        mainAxisSize: MainAxisSize.min,
        children: <Widget>
        [
          const Text("You have reached all levels! Impressive! What you wanna do next?", style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(width: 20, height: 20), //Добавляет пространство между текстом и первой кнопкой
          ElevatedButton
          (
            style: ElevatedButton.styleFrom
            (
              foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
              backgroundColor: const Color.fromARGB(255, 22, 100, 10),
            ),
            onPressed: () => gameRef.resetGame(),
            child: const Text("Reset Game")
          ),
          const SizedBox(height: 15, width: 10,), //Добавляет пространство между кнопками
          ElevatedButton
          (
            style: ElevatedButton.styleFrom
            (
              foregroundColor: const Color.fromARGB(255, 255, 255, 255), //Текст
              backgroundColor: const Color.fromARGB(255, 119, 10, 10), //Кнопка
            ),
            onPressed: () => gameRef.exitGame(),
            child: const Text("Exit")
          ),
        ],
      ),
    );
  }
}