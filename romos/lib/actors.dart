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
  Player({required this.character});

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
    idleAnimation = SpriteAnimation.fromFrameData(game.images.fromCache('Characters/Animations/Ghost/Ghost idle.png'), 
    SpriteAnimationData.sequenced
      (
        amount: 5, 
        stepTime: stepTime, 
        textureSize: Vector2.all(64)
      )
    );

    upAnimation = _spriteAnimation();
    
    //List of all animations
    animations = 
    {
      PlayerStates.idle: idleAnimation,
      PlayerStates.up: upAnimation,
    };
    //Set current animation
    current = PlayerStates.idle;
  }

  SpriteAnimation _spriteAnimation()
  {
    return SpriteAnimation.fromFrameData(game.images.fromCache('Characters/Animations/$character/Ghost walk up.png'), 
    SpriteAnimationData.sequenced
      (
        amount: 5, 
        stepTime: stepTime, 
        textureSize: Vector2.all(64)
      )
    );
  }
}