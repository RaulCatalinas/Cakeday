import 'package:cakeday/constants/strings.dart' show accents, normalized;

String normalizeInitial(String name) {
  final char = name[0].toUpperCase();
  final index = accents.indexOf(char);

  return index != -1 ? normalized[index].toUpperCase() : char;
}
