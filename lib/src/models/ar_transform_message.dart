// To parse this JSON data, do
//
//     final arTransform = arTransformFromMap(jsonString);

import 'dart:convert';

class ArTransformMessage {
  ArTransformMessage( {this.position, this.rotation, this.scale, this.vector,this.component = "",});

  final _Position? position;
  final _Rotation? rotation;
  final _Position? scale;
  final _Position? vector;
  final String component;

  factory ArTransformMessage.fromJson(String str) =>
      ArTransformMessage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArTransformMessage.fromMap(Map<String, dynamic> json) =>
      ArTransformMessage(
        position: json["position"] == null
            ? null
            : _Position.fromMap(json["position"]),
        rotation: json["rotation"] == null
            ? null
            : _Rotation.fromMap(json["rotation"]),
        scale: json["scale"] == null ? null : _Position.fromMap(json["scale"]),
        vector:
            json["vector"] == null ? null : _Position.fromMap(json["vector"]),
        component: json["component"]
      );

  Map<String, dynamic> toMap() => {
        "position": position == null ? null : position!.toMap(),
        "rotation": rotation == null ? null : rotation!.toMap(),
        "scale": scale == null ? null : scale!.toMap(),
      };
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

  factory _Position.fromJson(String str) => _Position.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _Position.fromMap(Map<String, dynamic> json) => _Position(
        x: json["x"] == null ? null : json["x"].toDouble(),
        y: json["y"] == null ? null : json["y"].toDouble(),
        z: json["z"] == null ? null : json["z"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "x": x,
        "y": y,
        "z": z,
      };
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

  factory _Rotation.fromJson(String str) => _Rotation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _Rotation.fromMap(Map<String, dynamic> json) => _Rotation(
        x: json["_x"] == null ? null : json["_x"].toDouble(),
        y: json["_y"] == null ? null : json["_y"].toDouble(),
        z: json["_z"] == null ? null : json["_z"].toDouble(),
        w: json["_w"] == null ? 0.0 : json["_w"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_x": x,
        "_y": y,
        "_z": z,
        "_w": w,
      };
}
