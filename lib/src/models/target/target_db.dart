import 'dart:typed_data';

import 'package:flutter/services.dart';

class TargetDB {
  final Future<Uint8List> Function() fetchFileContent;
  final bool islocal;
  final String url;
  const TargetDB._(
      {required this.fetchFileContent,
      required this.islocal,
      required this.url});

  factory TargetDB.asset(String assetPath) {
    return TargetDB._(
      fetchFileContent: () async {
        var bytes = await rootBundle.load(assetPath);
        return bytes.buffer.asUint8List();
      },
      islocal: true,
      url: assetPath,
    );
  }
  factory TargetDB.network(String url) {
    return TargetDB._(
      fetchFileContent: () async {
        return Uint8List(0);
        // var bytes = await rootBundle.load(assetPath);
        // return bytes.buffer.asUint8List();
      },
      islocal: false,
      url: url,
    );
  }
}
