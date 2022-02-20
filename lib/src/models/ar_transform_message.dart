// To parse this JSON data, do
//
//     final arTransform = arTransformFromMap(jsonString);

import 'dart:convert';

class ArTransformMessage {
  ArTransformMessage({
    this.position,
    this.rotation,
    this.scale,
    this.vector,
    this.component = "",
  });

  final _Position? position;
  final _Rotation? rotation;
  final _Position? scale;
  final _Position? vector;
  final String component;

  factory ArTransformMessage.fromJson(String str) =>
      ArTransformMessage.fromMap(json.decode(str));

  factory ArTransformMessage.fromMap(Map<String, dynamic> json) =>
      ArTransformMessage(
          position: json["position"] == null
              ? null
              : _Position.fromMap(json["position"]),
          rotation: json["rotation"] == null
              ? null
              : _Rotation.fromMap(json["rotation"]),
          scale:
              json["scale"] == null ? null : _Position.fromMap(json["scale"]),
          vector:
              json["vector"] == null ? null : _Position.fromMap(json["vector"]),
          component: json["component"]);
}

class _Position {
  _Position({
    this.x,
    this.y,
    this.z,
  });

  final double? x;
  final double? y;
  final double? z;

  factory _Position.fromMap(Map<String, dynamic> json) => _Position(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
        z: json["z"]?.toDouble(),
      );
}

class _Rotation {
  _Rotation({
    required this.x,
    required this.y,
    required this.z,
    required this.w,
  });

  final double x;
  final double y;
  final double z;
  final double w;

  factory _Rotation.fromMap(Map<String, dynamic> json) => _Rotation(
        x: json["_x"]?.toDouble(),
        y: json["_y"]?.toDouble(),
        z: json["_z"]?.toDouble(),
        w: json["_w"]?.toDouble(),
      );
}
