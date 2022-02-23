import 'package:dream_xr/dream_xr.dart';

class HtmlPageBuilder {
  static const String _entityHtmlPlaceholder = "{{ENTITY_HTML_PLACEHOLDER}}";
  static const String _targetJSPlaceholder = "{{TARGET_JS_PLACEHOLDER}}";
  static const String _componentsJSPlaceholder = "{{COMPONENT_JS_PLACEHOLDER}}";
  static const String _targetFile = "./targets.mind";
  static const String _templetPage = '''
<!DOCTYPE html>
<html lang="en">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebMessageChannel Test</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://cdn.jsdelivr.net/gh/hiukim/mind-ar-js@1.0.0/dist/mindar-image.prod.js"></script>
    <script src="https://aframe.io/releases/1.2.0/aframe.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/hiukim/mind-ar-js@1.0.0/dist/mindar-image-aframe.prod.js"></script>

</head>

<body>
 
    <script>
        // variable that will represents the port used to communicate with the Dart side
        var port;

        function toScreenPosition(obj, camera) {
            var vector = new THREE.Vector3();

            var widthHalf = 0.5 * window.innerWidth;
            var heightHalf = 0.5 * window.innerHeight;

            obj.updateMatrixWorld();
            vector.setFromMatrixPosition(obj.matrixWorld);
            vector.project(camera);

            vector.x = (vector.x * widthHalf) + widthHalf;
            vector.y = - (vector.y * heightHalf) + heightHalf;

            return {
                x: vector.x,
                y: vector.y
            };

        };

        // listen for messages
        window.addEventListener('message', function (event) {
            if (event.data == 'capturePort') {
               console.log('capturePort Called');
                // capture port2 coming from the Dart side
                if (event.ports[0] != null) {
                    // the port is ready for communication,
                    // so you can use port.postMessage(message); wherever you want
                    port = event.ports[0];
                    console.log('capturePort Recieved Port');
                    // To listen to messages coming from the Dart side, set the onmessage event listener
                    port.onmessage = function (event) {
                        // event.data contains the message data coming from the Dart side 
                        console.log(event.data);
                    };
                }
            }
        }, false);


       $_componentsJSPlaceholder

        document.addEventListener("DOMContentLoaded", function () {
            const sceneEl = document.querySelector('a-scene');

            $_targetJSPlaceholder

        });

    </script>
    <a-scene mindar-image="imageTargetSrc: $_targetFile" vr-mode-ui="enabled: false"
        device-orientation-permission-ui="enabled: false">
        <a-camera position="0 0 0" look-controls="enabled: false" raycaster="far: 1.1.4; objects: .clickable">
        </a-camera>
            $_entityHtmlPlaceholder
        </a-entity>
    </a-scene>
</body>
</html>
''';

  Future<String> construct(List<ImageTarget> targets, TargetDB db) async {
    TargetHTMLBuilder entityHTMLBuilder = TargetHTMLBuilder();
    TargetJsBuilder entityJsBuilder = TargetJsBuilder();

    ComponentJsBuilder componentJsBuilder = ComponentJsBuilder();
    // List<String> componentNames = ["dream-component"];

    String componentJS = "";
    String targetJS = "";
    String htmlDom = "";

    for (var target in targets) {
      targetJS += entityJsBuilder.construct(target.targetName);

      List<String> componentNames = [];

      for (var component in target.children) {
        componentJS += componentJsBuilder.construct(component.id);
        componentNames.add(component.id);
      }

      htmlDom += entityHTMLBuilder.construct(target);
    }

    return _templetPage
        .replaceAll(
          _componentsJSPlaceholder,
          componentJS,
        )
        .replaceAll(
          _targetJSPlaceholder,
          targetJS,
        )
        .replaceAll(
          _entityHtmlPlaceholder,
          htmlDom,
        )
        .replaceAll(_targetFile, db.url);
  }
}
