class ComponentJsBuilder {
  static const String _templetContent = '''

        AFRAME.registerComponent('dream-component-name', {
            init: function () {
                this.worldpos = new THREE.Vector3();
                this.rotation = new THREE.Quaternion();
                this.worldScale = new THREE.Vector3();

            },
            tick: function (t) {
                var data = this.data;
                this.el.getObject3D("mesh").getWorldPosition(this.worldpos);
                this.el.getObject3D("mesh").getWorldQuaternion(this.rotation);
                this.el.getObject3D("mesh").getWorldScale(this.worldScale);

                var camera = document.querySelector('a-scene').camera;
                var worldMateix = this.el.getObject3D("mesh").matrixWorld;
                var eular = new THREE.Euler().setFromQuaternion(this.rotation);

            
                var vector = toScreenPosition(this.el.getObject3D("mesh"), camera);
               
                var jsondata = 
                {
                    "position": this.worldpos,
                    "rotation": eular, 
                    "scale": this.worldScale,
                    "vector": vector,
                    "component":'dream-component-name'
                };
                if (port !== undefined) {

                    port.postMessage(JSON.stringify(jsondata));
                }

            },
        });

''';

  String construct(String componentNames) {
    String content = "";

      content += _templetContent.replaceAll("dream-component-name", componentNames);

    return content;
  }
}
