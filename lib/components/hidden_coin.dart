import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class HiddenCoin extends PositionComponent {
  HiddenCoin({required super.position})
      : super(size: Vector2.all(24), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(CircleHitbox(collisionType: CollisionType.passive));
  }
}
