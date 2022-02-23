import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/cupertino.dart';

class WidgetTargetNode extends TargetNode {
  @override
  late final String id;
  @override
  final TransformPosition position;
  @override
  final TransformRotation rotation;
  @override
  final TransformScale scale;
  final Widget Function(BuildContext context, ARTransformation transformation)
      builder;
  WidgetTargetNode({
    required this.builder,
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
    id = generateRandomString(10);
  }

  factory WidgetTargetNode.child({
    required Widget child,
    TransformPosition position = const TransformPosition(
      0,
      0,
    ),
    TransformRotation rotation = const TransformRotation(
      0,
      0,
      0,
    ),
    TransformScale scale = const TransformScale(
      1,
      1,
    ),
  }) {
    return WidgetTargetNode(
      builder: (context, _) => child,
      position: position,
      rotation: rotation,
      scale: scale,
    );
  }

  @override
  ChildType get type => ChildType.widget;
}
