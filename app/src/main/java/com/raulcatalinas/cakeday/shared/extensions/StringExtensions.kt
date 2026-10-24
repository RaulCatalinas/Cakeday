package com.raulcatalinas.cakeday.shared.extensions

import com.raulcatalinas.cakeday.shared.constants.CHARS_WITHOUT_ACCENTS
import com.raulcatalinas.cakeday.shared.constants.CHARS_WITH_ACCENTS

// Maps an accented character to its unaccented form. No allocations.
private fun Char.withoutAccent(): Char {
    val index = CHARS_WITH_ACCENTS.indexOf(this)

    return if (index != -1) CHARS_WITHOUT_ACCENTS[index] else this
}

// Strips lone UTF-16 surrogates so text can render safely.
// Fast path: most strings have no surrogates, so nothing is allocated.
val String.safeForDisplay: String
    get() {
        if (none { it.isSurrogate() }) return this

        val buffer = StringBuilder(length)
        var i = 0

        while (i < length) {
            val unit = this[i]

            if (unit.isHighSurrogate()) {
                if (i + 1 < length && this[i + 1].isLowSurrogate()) {
                    buffer.append(unit).append(this[i + 1])
                    i++
                }
            } else if (!unit.isLowSurrogate()) {
                buffer.append(unit)
            }

            i++
        }

        return buffer.toString()
    }

// Sort key: unaccented, uppercase, without surrogates (emoji are ignored).
// Compute it once per item, never inside a comparator.
val String.normalized: String
    get() = buildString(length) {
        for (char in this@normalized) {
            if (!char.isSurrogate()) {
                append(char.withoutAccent().uppercaseChar())
            }
        }
    }

// First letter of the name, unaccented and uppercase, or '#' if there is none.
// Digits, spaces, emoji and symbols are skipped because they are not letters.
val String.normalizedInitial: Char
    get() {
        for (char in this) {
            if (char.isLetter()) return char.withoutAccent().uppercaseChar()
        }

        return '#'
    }