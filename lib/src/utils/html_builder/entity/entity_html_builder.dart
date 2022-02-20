import 'package:dream_xr/dream_xr.dart';

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
class TargetHTMLBuilder {
  static const String _targetIndex = "{{index}}";
  static const String _position = "{{position}}";
  static const String _scale = "{{scale}}";
  static const String _rotation = "{{rotation}}";
  static const String _id = "{{target-name}}";
  static const String _templetContent = '''
      <a-entity id="$_id" mindar-image-target="targetIndex: $_targetIndex" position="0 0 0" material="opacity: 0.0; transparent: true">
''';

  static const String _templetEnd = '''
</a-entity>
''';

  String construct(ImageTarget target) {
    ComponentHTMLBuilder componentHTMLBuilder = ComponentHTMLBuilder();
    TransformPosition position = target.position;
    TransformRotation rotation = target.rotation;
    TransformScale scale = target.scale;
    String content = _templetContent
            .replaceAll(_id, target.targetName)
            .replaceAll(_targetIndex, "${target.targetIndex}")
        // .replaceAll(_position, "${position.x} ${position.y} 0")
        // .replaceAll(_rotation, "${rotation.x} ${rotation.y} ${rotation.z}")
        // .replaceAll(_scale, "${scale.x} ${scale.y} 0")
        ;

    for (var compnent in target.children) {
      content += componentHTMLBuilder.construct(compnent);
    }
    content += _templetEnd;
    return content;
  }
}
