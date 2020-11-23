import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_toolbox/generated/l10n.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'http.dart';

Future<File> picImage(BuildContext context) async {
  ImageSource source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(S.of(context).add_photo),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context, ImageSource.camera);
              },
              child: ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text(S.of(context).camera),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context, ImageSource.gallery);
              },
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text(S.of(context).gallery),
              ),
            ),
          ],
        );
      });

  if (source == null) return null;

  final pickedFile = await ImagePicker().getImage(source: source);
  if (pickedFile == null) return null;

  File image = File((pickedFile).path);
  return fixExifRotation(image);
}

Future<MultipartFile> picImageMultiFile(
    BuildContext context, String name) async {
  var image = await picImage(context);
  if (image == null) return null;
  return await multiFile(image, name);
}

Future<File> fixExifRotation(File image, {deleteOriginal: false}) async {
  List<int> imageBytes = await image.readAsBytes();

  List<int> result = await FlutterImageCompress.compressWithList(
    imageBytes,
    quality: 100,
    rotate: 0,
  );

  final String processedImageUuid = Uuid().v4();
  String imageExtension = p.basename(image.path);

  final String tempPath = (await getTemporaryDirectory()).path;

  File fixedImage = File('$tempPath/$processedImageUuid$imageExtension');

  await fixedImage.writeAsBytes(result);

  if (deleteOriginal) await image.delete();

  return fixedImage;
}
