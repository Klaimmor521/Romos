import 'dart:async';
import 'dart:math';
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
  Keeper({super.position, super.size});

  static const stepTime = 0.2;
  final textureSize = Vector2.all(64);
  Vector2 velocity = Vector2.zero();
  Direction direction = Direction.left;
  static const moveSpeed = 50;
  static const detectionRadius = 250;
  late final Player player;
  List<CollisionBlock> collisionBlocks = [];
  CustomHitbox hitbox = CustomHitbox(offsetX: 15, offsetY: 10, width: 47, height: 69);

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _leftAnimation;
  late final SpriteAnimation _upAnimation;
  late final SpriteAnimation _downAnimation;
  late final SpriteAnimation _rightAnimation;

  @override
  FutureOr<void> onLoad() 
  {
    priority = 1;
    debugMode = true;
    scale = Vector2.all(1.6);
    player = game.player;

    add(
      RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
        collisionType: CollisionType.passive
      ),
    );

    _loadAllAnimations();
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
    return SpriteAnimation.fromFrameData(game.images.fromCache('Characters/Animations/Earth keeper/Earth keeper $state.png'), 
    SpriteAnimationData.sequenced(amount: amount, stepTime: stepTime, textureSize: textureSize));
  }

  void _updateState(double dt) 
  {
    Vector2 target = player.absolutePosition - absolutePosition; //playerPosition - keeperPosition
    double distance = sqrt(pow(target.x, 2) + pow(target.y, 2));
    if(distance <= detectionRadius)
    {
      switch(direction)
      {
        case Direction.down:
          current = State.down;
          target.y += moveSpeed;
        case Direction.up:
          current = State.up;
          target.y -= moveSpeed;
        case Direction.left:
          current = State.left;
          target.x -= moveSpeed;
        case Direction.right:
          current = State.right;
          target.x += moveSpeed;
        default:
          current = State.idle;
      }
      velocity = Vector2(target.x, target.y);
      position += velocity * dt;
    }
  }
  
  void _checkHorizontalCollisions()
  {
    for (final block in collisionBlocks) 
    {
      if (block.isWalls && checkCollision(this, block))
      {
        if (velocity.x > 0.0) 
        { // right
          velocity.x = 0.0;
          position.x = block.x - hitbox.offsetX - hitbox.width;
          break;
        }
        else if (velocity.x < 0.0) 
        { // left
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
        { // down
          velocity.y = 0.0;
          position.y = block.y - hitbox.height - hitbox.offsetY;
          break;
        } 
        else if (velocity.y < 0.0) 
        { // up
          velocity.y = 0.0;
          position.y = block.y + block.height - hitbox.offsetY;
          break;
        }
      }
    }
  }
}