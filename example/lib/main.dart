import 'package:dream_xr/dream_xr.dart';
import 'package:flutter/material.dart';

import 'cube.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ImageARWidget(
        targetDB: TargetDB.network("https://puzzlehack.b-cdn.net/targets.mind"),
        tagets: [
          ImageTarget(
            targetIndex: 0,
            children: [
              WidgetTargetNode.child(
                child: Container(
                  color: Colors.pink.withOpacity(0.5),
                  child: const Center(
                    child: Text("Hello World"),
                  ),
                ),
              ),
              ModelTargetNode(
                  modelUrl: "https://puzzlehack.b-cdn.net/cube_grassland.glb",
                  position: const TransformPosition(0.5, -0.5),
                  scale: const TransformScale(0.1, 0.1, 0.1),
                  rotation: const TransformRotation(90, 0, 0)),
              WidgetTargetNode(
                position: const TransformPosition(0.1, -0.1),
                scale: const TransformScale(2.0,2.0,2.0),
                builder: (context, transformation) {
                  return CustomCube(
                    angleX: transformation.rotation.y,
                    angleY: transformation.rotation.x,
                    width: transformation.size.width, //*
                    // transformation.scale.x, //transformation.size.width transformation.scale.x,
                    height:
                        transformation.size.height, //* transformation.scale.y,
                    // transformation.size.height* transformation.scale.y,
                    depth: 100,
                    faceWidgets: CubeFaceWidgets(
                      topFace: (_, size) => Container(
                        //width: size.width,
                        //height: size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.red,
                          Colors.yellow,
                          Colors.green,
                        ])),
                        child: const Center(
                          child: Text("Hello World"),
                        ),
                      ),
                      leftFace: (_, size) => Container(
                        //width: size.width,
                        //height: size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.blue,
                          Colors.yellow,
                          Colors.green,
                        ])),
                        child: const Center(
                          child: Text("Hello World"),
                        ),
                      ),
                      rightFace: (_, size) => Container(
                        //width: size.width,
                        //height: size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.red,
                          Colors.pink,
                          Colors.green,
                        ])),
                        child: const Center(
                          child: Text("Hello World"),
                        ),
                      ),
                      upFace: (_, size) => Container(
                        //width: size.width,
                        //height: size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.red,
                          Colors.yellow,
                          Colors.cyan,
                        ])),
                        child: const Center(
                          child: Text("Hello World"),
                        ),
                      ),
                      downFace: (_, size) => Container(
                        //width: size.width,
                        //height: size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.purple,
                          Colors.yellow,
                          Colors.green,
                        ])),
                        child: const Center(
                          child: Text("Hello World"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
