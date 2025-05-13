import 'dart:convert';

String prettyJson(dynamic json, [int spacesAmount = 4]) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}
