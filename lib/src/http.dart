import 'dart:io';

import 'package:async/async.dart';
import 'package:chopper2/chopper2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toolbox/generated/i18n.dart';
import 'package:flutter_toolbox/src/log.dart';
import 'package:flutter_toolbox/src/ui/toast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'model/error/error_response.dart';

Future<http.MultipartFile> multiFile(File image, String name) async {
  var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
  var length = await image.length();

  var multipartFile =
      http.MultipartFile(name, stream, length, filename: basename(image.path));

  return multipartFile;
}

Future safeRequest<T>(
  BuildContext context,
  Future<Response<T>> request, {
  Function(T result) onSuccess,
  Function(ErrorResponse error) onError,
  Function(dynamic error) onUnknownError,
  bool showServerErrorMessage = true,
}) async {
  try {
    final Response response = await request;
    if (response.isSuccessful) {
      onSuccess?.call(response.body);
    } else {
      final error = (response.error as ErrorResponse).error;
      if (showServerErrorMessage) {
        if (error == 'Unauthorized access' || error == 'Unauthorized')
          errorToast(S.of(context).the_email_address_or_password_is_wrong);
        else
          errorToast(error);
      }
      onError?.call(response.error);
    }
  } on SocketException catch (e) {
    d2('SocketException-> $e');
    errorToast(S.of(context).please_check_your_connection);
  } on ErrorResponse catch (e) {
    d2('ErrorResponse-> $e');
    if (showServerErrorMessage) errorToast(e.error);

    onError?.call(e);
  } catch (e) {
    d2('UnknownError-> $e');
    onUnknownError?.call(e);
    errorToast(S.of(context).server_error);
  }
}
