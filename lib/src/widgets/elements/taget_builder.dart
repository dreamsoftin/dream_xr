import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/material.dart';

class ImageTagetBuilder extends StatelessWidget {
  const ImageTagetBuilder({Key? key, required this.imageTarget})
      : super(key: key);
  final ImageTarget imageTarget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var item in imageTarget.children) ...{
          ValueListenableBuilder<ARTransformation?>(
            valueListenable: item.transformation,
            builder:
                (BuildContext context, ARTransformation? value, Widget? child) {
              if (value == null) return Container();

              if (item is WidgetTargetChild) {
                return Transform(
                  alignment: Alignment.topLeft,
                  transform: value.matrix,
                  child: item.builder(context, value),
                );
              }
              return Container();
            },
          )
        }
      ],
    );
  }
}
