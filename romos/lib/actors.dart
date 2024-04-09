import 'dart:async';
import 'package:flame/components.dart';
import 'package:romos/romos.dart';

enum PlayerStates
{
  idle, up, down, left, right
}

enum PlayerDirection
{
  left, right, up, down, none
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<Romos>
{
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation upAnimation;
  late final SpriteAnimation leftAnimation;
  late final SpriteAnimation rightAnimation;
  late final SpriteAnimation downAnimation;
  final double stepTime = 0.2;

  PlayerDirection playerDirection = PlayerDirection.down;
  double moveSpeed = 250;
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad()
  {
    _loadAllAnimations();
    scale = Vector2.all(1.5); //Sprite scale
    return super.onLoad();
  }

  @override
  void update(double dt) 
  {
    _updatePlayerMovement(dt);
    super.update(dt);
  }
  
  void _loadAllAnimations() 
  {
    idleAnimation = _spriteAnimation('Ghost idle', 5);
    upAnimation = _spriteAnimation('Ghost walk up', 5);
    leftAnimation = _spriteAnimation('Ghost walk left', 5);
    downAnimation = _spriteAnimation('Ghost walk down', 5);
    rightAnimation = _spriteAnimation('Ghost walk right', 5);
    
    //List of all animations
    animations = 
    {
      PlayerStates.idle: idleAnimation,
      PlayerStates.up: upAnimation,
      PlayerStates.left: leftAnimation,
      PlayerStates.right: rightAnimation,
      PlayerStates.down: downAnimation
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
  
  void _updatePlayerMovement(double dt) 
  {
    double directionX = 0.0;
    double directionY = 0.0;
    switch (playerDirection) 
    {
      case PlayerDirection.left:
        current = PlayerStates.left;
        directionX -= moveSpeed;
        break;
      case PlayerDirection.right:
        current = PlayerStates.right;
        directionX += moveSpeed;
        break;
      case PlayerDirection.up:
        current = PlayerStates.up;
        directionY -= moveSpeed;
        break;
      case PlayerDirection.down:
        current = PlayerStates.down;
        directionY += moveSpeed;
        break;
      case PlayerDirection.none:
        break;
      default:
    }
    velocity = Vector2(directionX, directionY);
    position += velocity * dt;
  }
}