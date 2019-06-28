import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

errorToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIos: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
successToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIos: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );
}

toast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 1,
  );
}
