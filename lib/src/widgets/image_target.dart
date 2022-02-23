import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/cupertino.dart';

class ImageTarget {
  final int targetIndex;
  final VoidCallback? onFound;
  final VoidCallback? onLost;
  final List<TargetNode> children;
  late final String targetName;

  final TransformPosition position;

  final TransformRotation rotation;

  final TransformScale scale;
  ImageTarget({
    required this.targetIndex,
    this.onFound,
    this.onLost,
    this.children = const [],
    this.position = const TransformPosition(
      0,
      0,
    ),
    this.rotation = const TransformRotation(
      0,
      0,
      0,
    ),
    this.scale = const TransformScale(
      1,
      1,
    ),
  }) {
    targetName = generateRandomString(10);
  }

  void onLostMarker() {
    for (var element in children) {
      element.hide();
    }
  }

  void onMarkerFound() {
    for (var element in children) {
      element.show();
    }
  }
}
