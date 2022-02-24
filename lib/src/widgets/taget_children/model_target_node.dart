 import 'package:dream_xr/dream_xr.dart';

class ModelTargetNode extends TargetNode{
   @override
  late final String id;
  @override
  final TransformPosition position;
  @override
  final TransformRotation rotation;
  @override
  final TransformScale scale;
final String modelUrl;
  ModelTargetNode({
    required this.modelUrl,
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
      1,
    ),
  }) {
    id = generateRandomString(10);
  }

  @override
  ChildType get type => ChildType.model;
  
}