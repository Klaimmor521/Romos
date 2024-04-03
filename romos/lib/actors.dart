import 'dart:async';
import 'package:flame/components.dart';
import 'package:romos/romos.dart';

enum PlayerStates
{
  idle, up, down, left, right
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<Romos>
{
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation upAnimation;
  final double stepTime = 0.2;

  @override
  FutureOr<void> onLoad()
  {
    _loadAllAnimations();
    scale = Vector2.all(1.5); //Sprite scale
    return super.onLoad();
  }
  
  void _loadAllAnimations() 
  {
    idleAnimation = _spriteAnimation('Ghost idle', 5);
    upAnimation = _spriteAnimation('Ghost walk up', 5);
    
    //List of all animations
    animations = 
    {
      PlayerStates.idle: idleAnimation,
      PlayerStates.up: upAnimation,
    };
    //Set current animation
    current = PlayerStates.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount)
  {
    return SpriteAnimation.fromFrameData(game.images.fromCache('Characters/Animations/$character/$state.png'), 
    SpriteAnimationData.sequenced
      (
        amount: amount, 
        stepTime: stepTime, 
        textureSize: Vector2.all(64)
      )
    );
  }
}