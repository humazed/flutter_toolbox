import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'http.dart';

Future<File> picImage(BuildContext context) async {
  ImageSource source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add photo'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, ImageSource.camera);
              },
              child: ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery);
              },
              child: ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
              ),
            ),
          ],
        );
      });

  if (source == null) return null;

  File image = await ImagePicker.pickImage(source: source);
  return image;
}

Future<MultipartFile> picImageMultiFile(
    BuildContext context, String name) async {
  var image = await picImage(context);
  if (image == null) return null;
  return await multiFile(image, name);
}
