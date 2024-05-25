import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:romos/collision_block.dart';
import 'package:romos/custom_hitbox.dart';
import 'package:romos/romos.dart';
import 'package:romos/player.dart';
import 'package:romos/utils.dart';

enum State {idle, left, down, right, up}

enum Direction {left, right, up, down, none}

class Keeper extends SpriteAnimationGroupComponent with HasGameRef<Romos>, CollisionCallbacks
{
  final String type;
  Keeper({super.position, super.size, this.type = 'Earth keeper'});

  static const stepTime = 0.2;
  final textureSize = Vector2.all(64);
  Vector2 velocity = Vector2.zero();
  Direction direction = Direction.left;
  static const moveSpeed = 70.0;
  static const detectionRadius = 300;
  late final Player player;
  List<CollisionBlock> collisionBlocks = [];
  CustomHitbox hitbox = CustomHitbox(offsetX: 20, offsetY: 10, width: 40, height: 69);

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _leftAnimation;
  late final SpriteAnimation _upAnimation;
  late final SpriteAnimation _downAnimation;
  late final SpriteAnimation _rightAnimation;

  @override
  FutureOr<void> onLoad() 
  {
    priority = 1;
    //debugMode = true;
    _loadAllAnimations();
    scale = Vector2.all(1.6);
    player = game.player;

    add(
      RectangleHitbox
      (
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
      ),
    );

    return super.onLoad();
  }

  @override
  void update(double dt) 
  {
    _updateState(dt);
    _checkHorizontalCollisions();
    _checkVerticalCollisions();
    super.update(dt);
  }
  
  void _loadAllAnimations() 
  {
    _idleAnimation = _spriteAnimation('idle', 4);
    _leftAnimation = _spriteAnimation('left', 6);
    _upAnimation = _spriteAnimation('up', 6);
    _downAnimation = _spriteAnimation('down', 6);
    _rightAnimation = _spriteAnimation('right', 6);

    animations = 
    {
      State.idle: _idleAnimation,
      State.down: _downAnimation,
      State.right: _rightAnimation,
      State.left: _leftAnimation,
      State.up: _upAnimation
    };

    current = State.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount)
  {
    return SpriteAnimation.fromFrameData(game.images.fromCache('Characters/Animations/Keeper/$type $state.png'), 
    SpriteAnimationData.sequenced(amount: amount, stepTime: stepTime, textureSize: textureSize));
  }

  void _updateState(double dt)
  {
    Vector2 target = player.absolutePosition - absolutePosition;
    double distance = target.length;
    if(distance <= detectionRadius)
    {
      if(target.x.abs() > target.y.abs())
      {
        if(target.x > 0)
        {
          current = State.right;
          direction = Direction.right;
        }
        else
        {
          current = State.left;
          direction = Direction.left;
        }
      }
      else
      {
        if(target.y > 0)
        {
          current = State.down;
          direction = Direction.down;
        }
        else
        {
          current = State.up;
          direction = Direction.up;
        }
      }
      velocity = target.normalized() * moveSpeed;
      position += velocity * dt;
      //switch(direction)
      // {
      //   case Direction.down:
      //     current = State.down;
      //     //target.y += moveSpeed * dt;
      //     break;
      //   case Direction.up:
      //     current = State.up;
      //     //target.y -= moveSpeed * dt;
      //     break;
      //   case Direction.left:
      //     current = State.left;
      //     //target.x -= moveSpeed * dt;
      //     break;
      //   case Direction.right:
      //     current = State.right;
      //     //target.x += moveSpeed * dt;
      //     break;
      //   case Direction.none:
      //     current = State.idle;
      //     velocity = Vector2.zero();
      //     break;
      //   default:
      //     current = State.idle;
      // }
      // //velocity = Vector2(target.x, target.y);
      // position += velocity * dt;
    }
    else
    {
      current = State.idle;
      direction = Direction.right;
      velocity = Vector2.zero();
    }
  }
  
  void _checkHorizontalCollisions()
  {
    for (final block in collisionBlocks) 
    {
      if (block.isWalls && checkCollision(this, block))
      {
        if (velocity.x > 0.0) 
        { //right
          velocity.x = 0.0;
          position.x = block.x - hitbox.offsetX - hitbox.width;
          break;
        }
        else if (velocity.x < 0.0) 
        { //left
          velocity.x = 0.0;
          position.x = block.x + block.width - hitbox.offsetX;
          break;
        }
      }
    }
  }
  
  void _checkVerticalCollisions() 
  {
    for (final block in collisionBlocks) 
    {
      if (block.isWalls && checkCollision(this, block)) 
      {
        if (velocity.y > 0.0) 
        { //down
          velocity.y = 0.0;
          position.y = block.y - hitbox.height - hitbox.offsetY;
          break;
        } 
        else if (velocity.y < 0.0) 
        { //up
          velocity.y = 0.0;
          position.y = block.y + block.height - hitbox.offsetY;
          break;
        }
      }
    }
  }
}