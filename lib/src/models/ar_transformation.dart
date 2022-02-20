
import 'package:flutter/material.dart';

class ARTransformation {
  final TransformPosition position;
  final TransformRotation rotation;
  final TransformScale scale;
  final Size size;
  Matrix4 get matrix => Matrix4.identity()
    ..translate(
      position.x,
      position.y,
    )
    ..scale(
      scale.x,
      scale.y,
    )
    ..rotateZ(rotation.z)
    ..rotateX(rotation.x)
    ..rotateY(rotation.y);
  const ARTransformation(this.position, this.rotation, this.scale, this.size);
}

class TransformPosition {
  final double x;
  final double y;

  const TransformPosition(this.x, this.y);
}

class TransformScale {
  final double x;
  final double y;

  const TransformScale(this.x, this.y);
}

class TransformRotation {
  final double x;
  final double y;
  final double z;

  const TransformRotation(this.x, this.y, this.z);
}