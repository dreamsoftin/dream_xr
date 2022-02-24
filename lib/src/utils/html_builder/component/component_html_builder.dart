import 'package:dream_xr/dream_xr.dart';

class ComponentHTMLBuilder {
  static const String _position = "{{position}}";
  static const String _scale = "{{scale}}";
  static const String _rotation = "{{rotation}}";
  static const String _model = "{{model_source}}";
  static const String _templetContent = '''
       <a-plane  id="example-plane" class="clickable" material="side: double; color: #EF2D5E; transparent: true; opacity: 0.0"  position= "$_position" rotation= "$_rotation" scale="$_scale" height="1"
                width="1" dream-component-name></a-plane>
''';

  static const String _templetModelContent = '''
<a-gltf-model rotation="$_rotation" position="$_position" scale="$_scale" src="$_model">
''';

  String construct(TargetNode componentName) {
    TransformPosition position = componentName.position;
    TransformRotation rotation = componentName.rotation;
    TransformScale scale = componentName.scale;
    return (componentName.type == ChildType.model
            ? _templetModelContent.replaceAll(
                _model, (componentName as ModelTargetNode).modelUrl)
            : _templetContent)
        .replaceAll("dream-component-name", componentName.id)

        ///
        /// Extra 0.5 to move center to top Left
        ///
        .replaceAll(_position, "${position.x - 0.5} ${position.y + 0.5} 0")
        .replaceAll(_rotation, "${rotation.x} ${rotation.y} ${rotation.z}")
        .replaceAll(_scale, "${scale.x} ${scale.y} ${scale.z}");
  }
}
