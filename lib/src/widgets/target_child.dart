import 'dart:developer';

import 'package:dream_xr/dream_xr.dart';
import 'package:dream_xr/src/utils/extension/extension.dart';
import 'package:flutter/cupertino.dart';

abstract class TargetChild {
  String get id;
  ValueNotifier<ARTransformation?> transformation = ValueNotifier(null);
  bool _isVisible = false;
  void hide() {
    _isVisible = false;
    transformation.value = null;
  }

  void show() {
    _isVisible = true;
  }

  void handleTransformation(
      ArTransformMessage transform, double windowWidth, double windowHeight) {
    if (!_isVisible) return;

    var widthScale = (transform.scale!.x! / ((transform.position!.z!).abs()));
    var heightScale = (transform.scale!.y! / ((transform.position!.z!).abs()));

    var mappedTranslationX =
        transform.vector!.x! - (windowWidth / 2) * widthScale;
    var mappedTranslationY =
        transform.vector!.y! - (windowHeight / 2) * heightScale;

    log('''

Received Translation : ${transform.position!.x!.toStringAsFixed(2)} X  ${transform.position!.y!.toStringAsFixed(2)} X ${transform.position!.z!.toStringAsFixed(2)}
Mapped Translation : ${mappedTranslationX.toStringAsFixed(2)} X  ${mappedTranslationY.toStringAsFixed(2)} 

Received Scale : ${transform.scale!.x!.toStringAsFixed(2)} X  ${transform.scale!.y!.toStringAsFixed(2)} X ${transform.scale!.z!.toStringAsFixed(2)}
Mapped Scale : ${widthScale.toStringAsFixed(2)} X  ${heightScale.toStringAsFixed(2)}

Rotation received z : ${transform.rotation!.z}
Rotation received y : ${transform.rotation!.y}
Rotation received x : ${transform.rotation!.x}

''');

    transformation.value = ARTransformation(
        TransformPosition(mappedTranslationX, mappedTranslationY),
        TransformRotation(
          transform.rotation!.x,
          -transform.rotation!.y,
          -transform.rotation!.z,
        ),
        TransformScale(
          widthScale,
          heightScale,
        ),
        Size(windowWidth, windowHeight));
  }
}

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

class FlutterWidgetTargetChild extends TargetChild {
  @override
  late final String id;

  final Offset offset;
  final Widget Function(BuildContext context, ARTransformation transformation)
      builder;
  FlutterWidgetTargetChild({
    required this.builder,
    this.offset = Offset.zero,
  }) {
    id = generateRandomString(10);
  }

  factory FlutterWidgetTargetChild.child({
    required Widget child,
    Offset offset = Offset.zero,
  }) {
    return FlutterWidgetTargetChild(
      builder: (context, _) => child,
      offset: offset,
    );
  }
}
