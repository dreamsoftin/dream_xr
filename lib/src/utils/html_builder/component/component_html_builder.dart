class ComponentHTMLBuilder {
  static const String _templetContent = '''
       <a-plane id="example-plane" class="clickable" color="transparent" opaciy="0.5" position="0 0 0" height="1"
                width="1" rotation="0 0 0" dream-component-name></a-plane>
''';

  String construct(String componentName) {
    return _templetContent.replaceAll("dream-component-name", componentName);
  }
}
