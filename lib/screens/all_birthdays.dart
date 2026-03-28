import 'dart:async' show Timer;

import 'package:cakeday/components/app_search_bar.dart' show AppSearchBar;
import 'package:cakeday/components/header.dart' show Header;
import 'package:cakeday/components/render_all_birthdays.dart'
    show RenderAllBirthdays;
import 'package:cakeday/types/birthday_data.dart' show BirthdayData;
import 'package:cakeday/utils/search.dart' show filterBirthdays;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        Localizations,
        Padding,
        SafeArea,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        Widget;

class AllBirthdaysScreen extends StatefulWidget {
  const AllBirthdaysScreen({super.key});

  @override
  State<AllBirthdaysScreen> createState() => _AllBirthdaysScreenState();
}

class _AllBirthdaysScreenState extends State<AllBirthdaysScreen> {
  String searchQuery = '';
  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    final List<BirthdayData> allBirthdays = [
      BirthdayData(
        contactInfo: ('Carlos Pérez', '600123456', null, DateTime(1995, 3, 12)),
        birthday: DateTime(1995, 3, 12),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: ('Laura Gómez', '611987654', null, null),
        birthday: DateTime(1998, 7, 25),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: (
          'Miguel Torres',
          '622334455',
          null,
          DateTime(2000, 11, 5),
        ),
        birthday: DateTime(0, 11, 5),
        includeYear: false,
      ),
      BirthdayData(
        contactInfo: ('Ana Martínez', '633445566', null, null),
        birthday: DateTime(2000, 1, 30),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: ('David Sánchez', null, null, DateTime(1992, 9, 14)),
        birthday: DateTime(1992, 9, 14),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: ('Lucía Fernández', '644556677', null, null),
        birthday: DateTime(0, 5, 9),
        includeYear: false,
      ),
      BirthdayData(
        contactInfo: ('Javier Ruiz', '655667788', null, DateTime(1989, 12, 21)),
        birthday: DateTime(1989, 12, 21),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: ('Sofía Ramírez', null, null, null),
        birthday: DateTime(1997, 4, 3),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: (
          'Pablo Herrera',
          '666778899',
          null,
          DateTime(1999, 8, 18),
        ),
        birthday: DateTime(0, 8, 18),
        includeYear: false,
      ),
      BirthdayData(
        contactInfo: ('Elena Castro', '677889900', null, null),
        birthday: DateTime(2001, 6, 27),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: ('Raúl Navarro', '688990011', null, DateTime(1993, 2, 11)),
        birthday: DateTime(1993, 2, 11),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: ('Carmen Ortega', null, null, null),
        birthday: DateTime(0, 10, 6),
        includeYear: false,
      ),
      BirthdayData(
        contactInfo: ('Diego Molina', '699001122', null, DateTime(1990, 3, 19)),
        birthday: DateTime(1990, 3, 19),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: ('Marta Vega', '600112233', null, null),
        birthday: DateTime(1996, 7, 2),
        includeYear: true,
      ),
      BirthdayData(
        contactInfo: ('Álvaro León', null, null, DateTime(1994, 12, 31)),
        birthday: DateTime(0, 12, 31),
        includeYear: false,
      ),
    ];

    final filteredBirthdays = filterBirthdays(
      birthdays: allBirthdays,
      query: searchQuery,
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .all(25.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Header(text: 'All birthdays'),
              const Padding(padding: .symmetric(vertical: 16)),
              AppSearchBar(
                hintText: 'Search for reminders',
                onChanged: _onSearchChanged,
              ),
              const Padding(padding: .symmetric(vertical: 16)),
              filteredBirthdays.isEmpty
                  ? const Text('No results found')
                  : RenderAllBirthdays(allBirthdays: filteredBirthdays),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    debounce?.cancel();

    debounce = Timer(
      const Duration(milliseconds: 300),
      () => setState(() => searchQuery = value),
    );
  }
}
