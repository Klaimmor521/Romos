import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:romos/player_hitbox.dart';
import 'package:romos/romos.dart';
import 'package:romos/collision_block.dart';
import 'package:romos/utils.dart';

enum PlayerStates
{
  idle, up, down, left, right
}

enum PlayerDirection
{
  left, right, up, down, none
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<Romos>, KeyboardHandler
{
  String character;
  Player({position, this.character = 'Ghost'}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation upAnimation;
  late final SpriteAnimation leftAnimation;
  late final SpriteAnimation rightAnimation;
  late final SpriteAnimation downAnimation;
  final double stepTime = 0.2;

  PlayerDirection playerDirection = PlayerDirection.down;
  double moveSpeed = 250;
  Vector2 velocity = Vector2.zero();
  List<CollisionBlock> collisionBlocks = [];
  PlayerHitBox hitbox = PlayerHitBox(offsetX: 10, offsetY: 4, width: 10, height: 10);

  @override
  FutureOr<void> onLoad()
  {
    _loadAllAnimations();
    debugMode = true;
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    scale = Vector2.all(1.5); //Sprite scale
    return super.onLoad();
  }

  @override
  void update(double dt) 
  {
    _updatePlayerMovement(dt);
    // _checkHorizontalCollisions();
    // _checkVerticalCollisions();
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) 
  {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyS) || keysPressed.contains(LogicalKeyboardKey.arrowDown);
    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW) || keysPressed.contains(LogicalKeyboardKey.arrowUp);

    if(isLeftKeyPressed && isRightKeyPressed)
    {
      playerDirection = PlayerDirection.none;
    }
    else if(isLeftKeyPressed)
    {
      playerDirection = PlayerDirection.left;
    }
    else if(isRightKeyPressed)
    {
      playerDirection = PlayerDirection.right;
    }
    else if(isDownKeyPressed)
    {
      playerDirection = PlayerDirection.down;
    }
    else if(isUpKeyPressed)
    {
      playerDirection = PlayerDirection.up;
    }

    return super.onKeyEvent(event, keysPressed);
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
  
  //NEED TO FIX THIS BUG!!!
  void _checkHorizontalCollisions() 
  {
    for (final block in collisionBlocks) 
    {
      if (block.isWalls && checkCollision(this, block)) 
      {
        if (velocity.x > 0.0) 
        { // right
          position.x = block.x - (hitbox.offsetX + hitbox.width);
          velocity.x = 0.0;
        }
        else if (velocity.x < 0.0) 
        { // left
          position.x = block.x + block.width - hitbox.offsetX;
          velocity.x = 0.0;
        }
      }
    }
  }
  //NEED TO FIX THIS BUG!!! The player is teleporting >:(
  void _checkVerticalCollisions() 
  {
    for (final block in collisionBlocks) 
    {
      if (block.isWalls && checkCollision(this, block)) 
      {
        if (velocity.y > 0.0) 
        { // down
          position.y = block.y - (hitbox.offsetY + hitbox.height);
          velocity.y = 0.0;
        } 
        else if (velocity.y < 0.0) 
        { // up
          position.y = block.y + block.height - hitbox.offsetY;
          velocity.y = 0.0;
        }
      }
    }
  }
}