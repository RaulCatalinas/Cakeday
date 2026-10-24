package com.raulcatalinas.cakeday.shared.types

import androidx.compose.runtime.Immutable

@Immutable
data class ContactInfo(
    val name: String,
    val phone: String? = null,
    val photo: ByteArray? = null,
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as ContactInfo

        if (name != other.name) return false
        if (phone != other.phone) return false
        if (!photo.contentEquals(other.photo)) return false

        return true
    }

    override fun hashCode(): Int {
        var result = name.hashCode()
        result = 31 * result + phone.hashCode()
        result = 31 * result + (photo?.contentHashCode() ?: 0)
        return result
    }
}
