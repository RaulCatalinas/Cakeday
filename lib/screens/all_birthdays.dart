import 'dart:async' show Timer;

import 'package:cakeday/components/app_search_bar.dart';
import 'package:cakeday/components/create_birthday_button.dart'
    show CreateBirthdayButton;
import 'package:cakeday/components/header.dart';
import 'package:cakeday/components/render_all_birthdays.dart'
    show RenderAllBirthdays;
import 'package:cakeday/providers/birthdays_provider.dart'
    show birthdaysListProvider;
import 'package:cakeday/utils/search.dart' show filterBirthdays;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        Column,
        CrossAxisAlignment,
        Expanded,
        Localizations,
        MainAxisAlignment,
        Padding,
        SafeArea,
        Scaffold,
        Text,
        Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllBirthdaysScreen extends ConsumerStatefulWidget {
  const AllBirthdaysScreen({super.key});

  @override
  ConsumerState<AllBirthdaysScreen> createState() => _AllBirthdaysScreenState();
}

class _AllBirthdaysScreenState extends ConsumerState<AllBirthdaysScreen> {
  String searchQuery = '';
  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CreateBirthdayButton(),
      body: SafeArea(
        child: Padding(
          padding: const .directional(start: 25, end: 25, top: 0, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Header(text: 'All birthdays'),
              const Padding(padding: .symmetric(vertical: 16)),
              AppSearchBar(
                hintText: 'Search for reminders',
                onChanged: _onSearchChanged,
              ),
              const Padding(padding: .symmetric(vertical: 8)),
              Expanded(
                child: ref
                    .watch(birthdaysListProvider)
                    .when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (_, _) => const Center(
                        child: Padding(
                          padding: .symmetric(horizontal: 16),
                          child: Text(
                            "We couldn't load your birthdays. Please try again in a moment.",
                            textAlign: .center,
                          ),
                        ),
                      ),
                      data: (data) {
                        if (data.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: .symmetric(horizontal: 16),
                              child: Text(
                                'No birthdays yet.\nAdd someone using the add screen.',
                                textAlign: .center,
                              ),
                            ),
                          );
                        }

                        final filteredBirthdays = filterBirthdays(
                          birthdays: data,
                          query: searchQuery,
                          locale: Localizations.localeOf(context).toString(),
                        );

                        if (filteredBirthdays.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: .symmetric(horizontal: 16),
                              child: Text(
                                'No reminders match your search.\nTry another name or date.',
                                textAlign: .center,
                              ),
                            ),
                          );
                        }

                        return RenderAllBirthdays(
                          allBirthdays: filteredBirthdays,
                        );
                      },
                    ),
              ),
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
