import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

void d(Object object) {
  final output = "${Trace.current().frames[1].location} | $object";

  // the console prints the first 1000+ char and discard the rest so this work around.
  final pattern = RegExp('.{1,1000}'); // 1000 is the size of each chunk
  pattern.allMatches(output).forEach((match) => debugPrint(match.group(0)));
}

// Use this instead of d() for long string when you want to see output in the logcat when filtering by location.
// d() will not print the location for the first 1000+ char.
// Short for debug long.
void dl(Object object) {
  var location = Trace.current().frames[1].location;

  // the console prints the first 1000+ char and discard the rest so this work around.
  final pattern = RegExp('.{1,1000}'); // 1000 is the size of each chunk
  pattern
      .allMatches(object.toString())
      .forEach((match) => debugPrint("$location | ${match.group(0)}"));
}

void d2(Object object) {
  final output = "${Trace.current().frames[2].location} | $object";

  // the console prints the first 1000+ char and discard the rest so this work around.
  final pattern = RegExp('.{1,1000}'); // 1000 is the size of each chunk
  pattern.allMatches(output).forEach((match) => debugPrint(match.group(0)));
}

void dAll(Object object) {
  final output = "${Trace.current()} | $object";

  // the console prints the first 1000+ char and discard the rest so this work around.
  final pattern = RegExp('.{1,1000}'); // 1000 is the size of each chunk
  pattern.allMatches(output).forEach((match) => debugPrint(match.group(0)));
}
