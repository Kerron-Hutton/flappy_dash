import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_dash/components/hidden_coin.dart';
import 'package:flappy_dash/components/pipe.dart';

class PipePair extends PositionComponent {
  PipePair({required super.position, double gap = 200.0, double speed = 200})
      : _speed = speed,
        _gap = gap;

  final double _gap, _speed;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    addAll([
      Pipe(isFlipped: true, position: Vector2(0, -_gap / 2)),
      HiddenCoin(position: Vector2(30, 0)),
      Pipe(isFlipped: false, position: Vector2(0, _gap / 2)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= _speed * dt;
  }
}
