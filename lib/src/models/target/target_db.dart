import 'dart:typed_data';

import 'package:flutter/services.dart';

class TargetDB {
  final Future<Uint8List> Function() fetchFileContent;
  const TargetDB._({
    required this.fetchFileContent,
  });

  factory  TargetDB.asset(String assetPath) {
    return TargetDB._(fetchFileContent: () async {
      var bytes = await rootBundle.load(assetPath);
      return bytes.buffer.asUint8List();
    });
  }
}
