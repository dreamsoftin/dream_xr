import 'package:dream_xr/src/utils/html_builder/component/component_html_builder.dart';

///
///
///
///```html
/// <a-entity id="example-target" mindar-image-target="targetIndex: 0" position="0 0 0">
///     <a-plane id="example-plane" class="clickable" color="transparent" opaciy="0.5" position="0 0 0" height="0.5" width="1" rotation="0 0 0" dream-component-a>
///     </a-plane>
/// </a-entity>
/// ```
///
///
///
class EntityHTMLBuilder {
  static const String _targetIndex = "{{index}}";
  static const String _templetContent = '''
      <a-entity id="dream-target-name" mindar-image-target="targetIndex: $_targetIndex" position="0 0 0">
''';

  static const String _templetEnd = '''
</a-entity>
''';

  String construct(
      int targetIndex, String targetName, List<String> componentNames) {
    ComponentHTMLBuilder componentHTMLBuilder = ComponentHTMLBuilder();
    String content = _templetContent
        .replaceAll("dream-target-name", targetName)
        .replaceAll(_targetIndex, "$targetIndex");

    for (var compnent in componentNames) {
      content += componentHTMLBuilder.construct(compnent);
    }
    content += _templetEnd;
    return content;
  }
}
