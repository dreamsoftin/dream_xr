import 'package:dream_xr/dream_xr.dart';
import 'package:dream_xr/src/utils/extension/extension.dart';
import 'package:flutter/cupertino.dart';

import 'target_child.dart';

class ImageTarget {
  final int targetIndex;
  final VoidCallback? onFound;
  final VoidCallback? onLost;
  final List<TargetChild> children;
  late final String targetName;
  ImageTarget({
    required this.targetIndex,
    this.onFound,
    this.onLost,
    this.children = const [],
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
