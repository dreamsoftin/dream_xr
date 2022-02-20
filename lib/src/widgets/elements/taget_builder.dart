import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/material.dart';

class ImageTagetBuilder extends StatelessWidget {
  const ImageTagetBuilder({Key? key, required this.imageTarget})
      : super(key: key);
  final ImageTarget imageTarget;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (var item in imageTarget.children) ...{
          AspectRatio(
            aspectRatio: item.scale.x / item.scale.y,
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: ValueListenableBuilder<ARTransformation?>(
                valueListenable: item.transformation,
                builder: (BuildContext context, ARTransformation? value,
                    Widget? child) {
                  if (value == null) return Container();

                  if (item is WidgetTargetChild) {
                    return Transform(
                      alignment: const Alignment(-1, -1),
                      transform: value.matrix,
                      child: item.builder(context, value),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        }
      ],
    );
  }
}
