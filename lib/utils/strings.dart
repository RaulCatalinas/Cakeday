import 'package:cakeday/constants/regex.dart' show letterRegex;
import 'package:cakeday/constants/strings.dart'
    show charsWithAccents, charsWithoutAccents;
import 'package:characters/characters.dart' show StringCharacters;

extension StringNormalization on String {
  String get firstLetter {
    if (isEmpty) return '';

    for (final char in trim().characters) {
      if (!letterRegex.hasMatch(char)) continue;

      return char.toUpperCase();
    }

    return characters.first;
  }

  String get normalized {
    return toUpperCase().split('').map((char) {
      final index = charsWithAccents.indexOf(char);
      return index != -1 ? charsWithoutAccents[index].toUpperCase() : char;
    }).join();
  }

  String get normalizedInitial => normalized[0];
}
