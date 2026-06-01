import 'package:cakeday/constants/regex.dart' show letterRegex;
import 'package:cakeday/constants/strings.dart'
    show charsWithAccents, charsWithoutAccents;
import 'package:characters/characters.dart' show StringCharacters;

extension StringNormalization on String {
  /// Strips lone UTF-16 surrogates so [Text] widgets can render safely.
  String get safeForDisplay {
    final buffer = StringBuffer();
    final units = codeUnits;

    for (var i = 0; i < units.length; i++) {
      final unit = units[i];

      if (unit >= 0xD800 && unit <= 0xDBFF) {
        if (i + 1 < units.length &&
            units[i + 1] >= 0xDC00 &&
            units[i + 1] <= 0xDFFF) {
          buffer
            ..writeCharCode(unit)
            ..writeCharCode(units[++i]);
        }
      } else if (unit < 0xDC00 || unit > 0xDFFF) {
        buffer.writeCharCode(unit);
      }
    }

    return buffer.toString();
  }

  String get firstLetter {
    final safe = safeForDisplay;
    if (safe.isEmpty) return '';

    for (final char in safe.trim().characters) {
      if (!letterRegex.hasMatch(char)) continue;

      return char;
    }

    return safe.trim().characters.first;
  }

  String get normalized {
    final buffer = StringBuffer();

    for (final char in safeForDisplay.characters) {
      final upper = char.toUpperCase();
      final index = charsWithAccents.indexOf(upper);
      buffer.write(
        index != -1 ? charsWithoutAccents[index].toUpperCase() : upper,
      );
    }

    return buffer.toString();
  }

  String get normalizedInitial {
    final safe = safeForDisplay.trim();
    if (safe.isEmpty) return '#';

    for (final char in safe.characters) {
      if (!letterRegex.hasMatch(char)) continue;

      final upper = char.toUpperCase();
      final index = charsWithAccents.indexOf(upper);
      return index != -1 ? charsWithoutAccents[index].toUpperCase() : upper;
    }

    return '#';
  }
}
