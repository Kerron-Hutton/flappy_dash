import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';

class Dash extends PositionComponent {
  Dash()
      : super(
          position: Vector2(0, 0),
          size: Vector2.all(80),
          anchor: Anchor.center,
        );

  final Vector2 _jumpForce = Vector2(0, -400);
  final Vector2 _gravity = Vector2(0, 900);

  Vector2 _velocity = Vector2.zero();

  late Sprite _dashSprite;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    _dashSprite = await Sprite.load('dash.png');
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

  void jump() {
    _velocity = _jumpForce;
  }
}
