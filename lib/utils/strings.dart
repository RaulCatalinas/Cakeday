import 'package:cakeday/constants/strings.dart'
    show charsWithAccents, charsWithoutAccents;

String normalizeInitial(String name) => normalizeName(name)[0];

String normalizeName(String name) {
  return name.toUpperCase().split('').map((char) {
    final index = charsWithAccents.indexOf(char);
    return index != -1 ? charsWithoutAccents[index].toUpperCase() : char;
  }).join();
}
