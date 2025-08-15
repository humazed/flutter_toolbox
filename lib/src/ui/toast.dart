import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

const int longDelay = 3500;
const Duration longDuration = Duration(milliseconds: longDelay);

void errorToast(String msg) {
  showToast(
    msg,
    duration: longDuration,
    backgroundColor: Colors.red,
    textStyle: const TextStyle(color: Colors.white, fontSize: 15),
  );
}

void successToast(String msg) {
  showToast(
    msg,
    duration: longDuration,
    backgroundColor: Colors.green,
    textStyle: const TextStyle(color: Colors.white, fontSize: 15),
  );
}

void toast(String msg) {
  showToast(
    msg,
    duration: longDuration,
  );
}
