<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A simple AR Plugin which allows you to place Flutter Widget in AR. This plugin uses Mind AR to work with AR.

## Features

* Allows to Place Flutter widget on Top of target.
* Allows to place GLB/GLTF Models.

#

<img src="https://puzzlehack.b-cdn.net/1647273449319.JPEG" alt="Puzzle Hack Example"/>


## Usage


```dart
    ImageARWidget(
        /// Your Target File.
        /// For this example scan any flutter logo
        targetDB: TargetDB.network("https://puzzlehack.b-cdn.net/targets.mind"), 
        tagets: [
          ImageTarget(
            targetIndex: 0,
            children: [
              /// Your Widget.
              WidgetTargetNode.child(
                child: Container(
                  color: Colors.pink.withOpacity(0.5),
                  child: const Center(
                    child: Text("Hello World"),
                  ),
                ),
              ),
              /// Your Target Model.
              ModelTargetNode(
                  modelUrl: "https://puzzlehack.b-cdn.net/cube_grassland.glb",
                  position: const TransformPosition(0.5, -0.5),
                  scale: const TransformScale(0.4, 0.4, 0.4),
                  rotation: const TransformRotation(90, 0, 0)),
            ],
          ),
          /// Works with Multiple Target as well
          ImageTarget(
            targetIndex: 1,
            position: const TransformPosition(
              0,
              0,
            ),
            children: [
              WidgetTargetNode.child(
                child: Container(
                  color: Colors.purple,
                  child: const Center(
                    child: Text("Hello World Index 2"),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
```

## Limitations
1. Models will always lies below Widget.
2. `.asset()` works only for android. For iOS you need to use `.network()` constructor for Target DB.

## Things to be implemented.
1. Support Loading asset files in iOS,
2. Provide Dart based implementation