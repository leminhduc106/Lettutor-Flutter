import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

extension StringFinding on String {
  bool containsInsensitive(String text) {
    return toUpperCase().contains(text.toUpperCase());
  }
}

class Utils {
  static String convertUint8ListToString(Uint8List uint8list) {
    return String.fromCharCodes(uint8list);
  }

  static Uint8List convertStringToUint8List(String str) {
    final List<dynamic> ccodeUnits = jsonDecode(str);
    final List<int> codeUnits = [];
    for (dynamic x in ccodeUnits) {
      codeUnits.add(x);
    }
    final Uint8List uInt8List = Uint8List.fromList(codeUnits);
    return uInt8List;
  }
}

class ImageHelper {
  static Future<Uint8List?> getCompressedImage(File? file,
      {int width = 512}) async {
    if (file == null) return null;
    Uint8List? compressedFile;
    try {
      compressedFile = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          minWidth: width,
          minHeight: width);
    } catch (e) {
      debugPrint(e.toString());
      compressedFile = null;
    }
    return compressedFile;
  }

  static Future<File> saveImagePermanently(String imgPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imgPath);
    final image = File('${directory.path}/$name');

    return File(imgPath).copy(image.path);
  }
}
