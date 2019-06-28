import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future<http.MultipartFile> multiFile(File image, String name) async {
  var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
  var length = await image.length();

  var multipartFile =
      http.MultipartFile(name, stream, length, filename: basename(image.path));

  return multipartFile;
}
