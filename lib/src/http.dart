import 'dart:io';

import 'package:async/async.dart';
import 'package:chopper/chopper.dart';
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
  Function(ErrorResponse result) onError,
}) async {
  try {
    final Response response = await request;
    if (response.isSuccessful) {
      if (onSuccess != null) await onSuccess(response.body);
    } else {
      final error = (response.error as ErrorResponse).error;
      if (error == 'Unauthorized access' || error == 'Unauthorized')
        errorToast(S.of(context).the_email_address_or_password_is_wrong);
      else
        errorToast(error);
      await onError(response.error);
    }
  } on Response<ErrorResponse> catch (e) {} on SocketException catch (e) {
    d('SocketException-> $e');
    errorToast(S.of(context).please_check_your_connection);
  } catch (e) {
    d('LoginScreenState#_submit UnknownError-> $e');
    errorToast(S.of(context).server_error);
  }
}
