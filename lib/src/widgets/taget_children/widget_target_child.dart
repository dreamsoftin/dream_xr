import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/cupertino.dart';

class WidgetTargetChild extends TargetChild {
  @override
  late final String id;

  final Offset offset;
  final Widget Function(BuildContext context, ARTransformation transformation)
      builder;
  WidgetTargetChild({
    required this.builder,
    this.offset = Offset.zero,
  }) {
    id = generateRandomString(10);
  }

  factory WidgetTargetChild.child({
    required Widget child,
    Offset offset = Offset.zero,
  }) {
    return WidgetTargetChild(
      builder: (context, _) => child,
      offset: offset,
    );
  }
}
