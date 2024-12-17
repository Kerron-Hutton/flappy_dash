import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/components/hidden_coin.dart';
import 'package:flappy_dash/components/pipe.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:logger/web.dart';

class Dash extends PositionComponent
    with CollisionCallbacks, HasGameRef<FlappyDashGame> {
  Dash()
      : super(
          position: Vector2(0, 0),
          size: Vector2.all(80),
          anchor: Anchor.center,
        );

  final Vector2 _jumpForce = Vector2(0, -550);
  final Vector2 _gravity = Vector2(0, 1500);

  Vector2 _velocity = Vector2.zero();

  late Sprite _dashSprite;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    _dashSprite = await Sprite.load('dash.png');
    _addHitBox();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _dashSprite.render(canvas, size: size);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _velocity += _gravity * dt;
    position += _velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is HiddenCoin) {
      other.removeFromParent();
      game.world.increaseScore();
    } else if (other is Pipe) {
      Logger().e('GAME OVER!!!!....');
    }
  }

  void jump() {
    _velocity = _jumpForce;
  }

  void _addHitBox() {
    final dashRadius = size.x / 2;

    add(CircleHitbox(
      position: size / 2 * 1.1,
      radius: dashRadius * 0.8,
      anchor: Anchor.center,
    ));
  }
}
