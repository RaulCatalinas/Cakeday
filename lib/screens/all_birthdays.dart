import 'dart:async' show Timer;

import 'package:cakeday/components/birthday/create_birthday_button.dart'
    show CreateBirthdayButton;
import 'package:cakeday/components/birthday/render_all_birthdays.dart'
    show RenderAllBirthdays;
import 'package:cakeday/components/common/app_search_bar.dart'
    show AppSearchBar;
import 'package:cakeday/components/common/header.dart' show Header;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/providers/birthdays_provider.dart'
    show birthdaysListProvider;
import 'package:cakeday/utils/search.dart' show BirthdayDataListSearch;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        Column,
        Expanded,
        Localizations,
        Padding,
        SafeArea,
        Scaffold,
        Text,
        Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValueExtensions, ConsumerState, ConsumerStatefulWidget;
import 'package:logkeeper/logkeeper.dart';

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
            crossAxisAlignment: .stretch,
            mainAxisAlignment: .start,
            children: [
              Header(text: AppLocalizations.of(context)!.all_birthdays_header),
              const Padding(padding: .symmetric(vertical: 16)),
              AppSearchBar(
                hintText: AppLocalizations.of(
                  context,
                )!.app_search_bar_hint_text,
                onChanged: _onSearchChanged,
              ),
              const Padding(padding: .symmetric(vertical: 8)),
              Expanded(
                child: ref
                    .watch(birthdaysListProvider)
                    .when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, stackTrace) {
                        LogKeeper.error('Error loading birthdays: $e');
                        LogKeeper.error('StackTrace: $stackTrace');

                        return Center(
                          child: Padding(
                            padding: const .symmetric(horizontal: 16),
                            child: Text(
                              AppLocalizations.of(
                                context,
                              )!.could_not_load_birthdays_error,
                              textAlign: .center,
                            ),
                          ),
                        );
                      },
                      data: (data) {
                        if (data.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const .symmetric(horizontal: 16),
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!.not_birthdays_yet_information,
                                textAlign: .center,
                              ),
                            ),
                          );
                        }

                        final filteredBirthdays = data.filtered(
                          query: searchQuery,
                          locale: Localizations.localeOf(context).toString(),
                        );

                        if (filteredBirthdays.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const .symmetric(horizontal: 16),
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!.no_search_matches_error,
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
