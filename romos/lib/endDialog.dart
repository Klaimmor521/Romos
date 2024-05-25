import 'package:flutter/material.dart';
import 'package:romos/romos.dart';

class EndDialog extends StatelessWidget
{
  final Romos gameRef;
  
  const EndDialog({required this.gameRef});

  @override
  Widget build(BuildContext context) 
  {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("You have reached all levels! What you wanna do next?", style: TextStyle(fontSize: 24)),
          ElevatedButton(
            onPressed: () 
            {
              Navigator.pop(context);
              gameRef.resetGame();
            },
            child: const Text("Reset game")
          ),
          ElevatedButton(
            onPressed: () 
            {
              Navigator.pop(context);
              gameRef.exitGame();
            },
            child: const Text("Exit")
          ),
        ],
      ),
    );
  }
}