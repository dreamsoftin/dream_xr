import 'package:recase/recase.dart';

class EntityJsBuilder {
  static const String _templetContent = '''

        const dreamTargetName = document.querySelector('#dream-target-name');

        dreamTargetName.addEventListener("targetFound", event => {
           var jsondata = {
               "target":"dream-target-name",
               "event":"target_found"
           }
           port.postMessage(JSON.stringify(jsondata));
        });

        
        dreamTargetName.addEventListener("targetLost", event => {
            var jsondata = {
                "target":"dream-target-name",
                "event":"target_lost"
            }
            port.postMessage(JSON.stringify(jsondata));
        });


''';

  String construct(String componentNames) {
    String content = "";
    ReCase caseChanger = ReCase(componentNames);
    content += _templetContent.replaceAll("dream-target-name", componentNames).replaceAll("dreamTargetName", caseChanger.camelCase);

    return content;
  }
}
