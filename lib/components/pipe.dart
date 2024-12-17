import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Pipe extends PositionComponent {
  Pipe({required bool isFlipped, required super.position})
      : _isFlipped = isFlipped;

  late Sprite _pipeSprite;
  final bool _isFlipped;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    _pipeSprite = await Sprite.load('pipe.png');
    anchor = Anchor.topCenter;

    final ratio = _pipeSprite.srcSize.y / _pipeSprite.srcSize.x;
    final pipeWidth = 85.0;

    size = Vector2(pipeWidth, pipeWidth * ratio);

    if (_isFlipped) {
      flipVertically();
    }

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _pipeSprite.render(canvas, size: size);
  }
}
