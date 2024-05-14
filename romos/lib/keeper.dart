import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:romos/romos.dart';
import 'package:romos/player.dart';

enum State {idle, left, down, right, up}

enum Direction {left, right, up, down, none}

class Keeper extends SpriteAnimationGroupComponent with HasGameRef<Romos>, CollisionCallbacks
{
  Keeper({super.position, super.size});

  static const stepTime = 0.2;
  final textureSize = Vector2.all(64);
  Vector2 velocity = Vector2.zero();
  static const moveSpeed = 200;
  static const detectionRadius = 300;
  late final Player player;
  //late final Keeper keeper;
  Direction direction = Direction.left;

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
        position: Vector2(15, 10),
        size: Vector2(47, 69),
      ),
    );

    _loadAllAnimations(); 
    _calculateRadius();
    return super.onLoad();
  }

  @override
  void update(double dt) 
  {
    _updateState();
    _movement(dt);
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

  void _movement(double dt) 
  {
    velocity.x = 0;
    velocity.y = 0;
    // double directionX = 0.0;
    // double directionY = 0.0;
    // switch(direction)
    // {
    //   case Direction.down:
    //     current = State.down;
    //     directionY += moveSpeed;
    //   case Direction.up:
    //     current = State.up;
    //     directionY -= moveSpeed;
    //   case Direction.left:
    //     current = State.left;
    //     directionX -= moveSpeed;
    //   case Direction.right:
    //     current = State.right;
    //     directionX += moveSpeed;
    //   case Direction.none:
    //     break;
    //   default:
    // }
    // velocity = Vector2(directionX, directionY);
    // position += velocity * dt;
  }

  bool playerInRadius()
  {
    return false;
  }

  void _updateState() 
  {
    Vector2 direction = player.absolutePosition - absolutePosition;
    double distance = sqrt(pow(direction.x, 2) + pow(direction.y, 2));
    if(distance <= detectionRadius)
    {
      print('Distance: $distance');
    }
  }
  
  void _calculateRadius() 
  {
    
  }
}