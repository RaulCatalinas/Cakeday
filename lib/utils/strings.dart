import 'package:cakeday/constants/strings.dart'
    show charsWithAccents, charsWithoutAccents;

extension StringNormalization on String {
  String get normalized {
    return toUpperCase().split('').map((char) {
      final index = charsWithAccents.indexOf(char);
      return index != -1 ? charsWithoutAccents[index].toUpperCase() : char;
    }).join();
  }

  String get normalizedInitial => normalized[0];
}
