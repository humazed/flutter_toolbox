import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

void d(String text) {
  var output = "${Trace.current().frames[1].location} | $text";

  // the console prints the first 1000+ char and discard the rest so this work around.
  final pattern = new RegExp('.{1,1000}'); // 1000 is the size of each chunk
  pattern.allMatches(output).forEach((match) => debugPrint(match.group(0)));
}
