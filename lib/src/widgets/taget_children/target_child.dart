
import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/material.dart';

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
    ArTransformMessage transform,
    double windowWidth,
    double windowHeight,
  ) {
    if (!_isVisible) return;

    var widthScale = (transform.scale!.x! / ((transform.position!.z!).abs()));
    var heightScale = (transform.scale!.y! / ((transform.position!.z!).abs()));

    var mappedTranslationX =
        transform.vector!.x! - (windowWidth / 2) * widthScale;
    var mappedTranslationY =
        transform.vector!.y! - (windowHeight / 2) * heightScale;

    //     log('''

    // Received Translation : ${transform.position!.x!.toStringAsFixed(2)} X  ${transform.position!.y!.toStringAsFixed(2)} X ${transform.position!.z!.toStringAsFixed(2)}
    // Mapped Translation : ${mappedTranslationX.toStringAsFixed(2)} X  ${mappedTranslationY.toStringAsFixed(2)}

    // Received Scale : ${transform.scale!.x!.toStringAsFixed(2)} X  ${transform.scale!.y!.toStringAsFixed(2)} X ${transform.scale!.z!.toStringAsFixed(2)}
    // Mapped Scale : ${widthScale.toStringAsFixed(2)} X  ${heightScale.toStringAsFixed(2)}

    // Rotation received z : ${transform.rotation!.z}
    // Rotation received y : ${transform.rotation!.y}
    // Rotation received x : ${transform.rotation!.x}

    // ''');

    transformation.value = ARTransformation(
      TransformPosition(
        mappedTranslationX,
        mappedTranslationY,
      ),
      TransformRotation(
        transform.rotation!.x,
        -transform.rotation!.y,
        -transform.rotation!.z,
      ),
      TransformScale(
        widthScale,
        heightScale,
      ),
      Size(
        windowWidth,
        windowHeight,
      ),
    );
  }
}

