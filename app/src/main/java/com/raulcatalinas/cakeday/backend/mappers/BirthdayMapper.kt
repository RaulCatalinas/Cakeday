package com.raulcatalinas.cakeday.backend.mappers

import com.raulcatalinas.cakeday.backend.entities.BirthdayEntity
import com.raulcatalinas.cakeday.shared.models.BirthdayModel
import com.raulcatalinas.cakeday.shared.types.ContactInfo
import java.time.LocalDate

fun BirthdayEntity.toDomain(): BirthdayModel {
    return BirthdayModel(
        id = id,
        contactInfo = ContactInfo(name = name, phone = phone),
        birthday = LocalDate.of(year, month, day),
        personalisedMessage = personalisedMessage,
        note = note,
        notificationHour = notificationHour,
        notificationMinute = notificationMinute,
        notificationScheduled = notificationScheduled,
        createdAt = createdAt
    )
}

fun BirthdayModel.toEntity(): BirthdayEntity {
    return BirthdayEntity(
        id = id,
        name = contactInfo.name,
        phone = contactInfo.phone,
        day = birthday.dayOfMonth,
        month = birthday.monthValue,
        year = birthday.year,
        personalisedMessage = personalisedMessage,
        note = note,
        notificationHour = notificationHour,
        notificationMinute = notificationMinute,
        notificationScheduled = notificationScheduled,
        createdAt = createdAt
    )
}