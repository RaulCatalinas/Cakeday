package com.raulcatalinas.cakeday.services.constants

val phoneRegex = Regex("[\\s\\-()]")

const val WHATSAPP_SCHEME: String = "whatsapp"
const val WHATSAPP_AUTHORITY: String = "send"
const val WHATSAPP_PHONE_QUERY_PARAM: String = "phone"
const val WHATSAPP_TEXT_QUERY_PARAM: String = "text"
const val EXTRA_PHONE: String = "phone"
const val EXTRA_MESSAGE: String = "message"
const val EXTRA_NAME: String = "name"