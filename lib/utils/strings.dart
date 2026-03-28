import 'package:cakeday/constants/strings.dart'
    show charsWithAccents, charsWithoutAccents;

String normalizeInitial(String name) {
  final char = name[0].toUpperCase();
  final index = charsWithAccents.indexOf(char);

  return index != -1 ? charsWithoutAccents[index].toUpperCase() : char;
}
