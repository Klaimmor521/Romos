import 'dart:async';
import 'package:flame/components.dart';
import 'package:romos/romos.dart';

enum State {idle, left, dowm, right, up}

class Keeper extends SpriteAnimationGroupComponent with HasGameRef<Romos>
{
  Keeper({super.position, super.size});

  static const stepTime = 0.05;
  final textureSize = Vector2(64, 64);

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _leftAnimation;
  late final SpriteAnimation _upAnimation;
  late final SpriteAnimation _downAnimation;
  late final SpriteAnimation _rightAnimation;

  @override
  FutureOr<void> onLoad() 
  {
    debugMode = true;
    //_loadAllAnimations(); ..Problem in load animation, error in stacks
    return super.onLoad();
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
      State.dowm: _downAnimation,
      State.right: _rightAnimation,
      State.left: _leftAnimation,
      State.up: _upAnimation
    };

    current = State.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount)
  {
    return SpriteAnimation.fromFrameData(game.images.fromCache('Earth keeper/Earth keeper $state'), 
    SpriteAnimationData.sequenced(amount: amount, stepTime: stepTime, textureSize: textureSize));
  }
}