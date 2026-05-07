import 'package:cakeday/components/birthday/create_birthday_button.dart'
    show CreateBirthdayButton;
import 'package:cakeday/components/birthday/reminder_card.dart'
    show ReminderCard;
import 'package:cakeday/components/common/gradient_card.dart' show GradientCard;
import 'package:cakeday/components/common/section_title.dart' show SectionTitle;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/providers/birthdays_provider.dart'
    show birthdaysListProvider;
import 'package:cakeday/utils/birthday_utils.dart'
    show filterTodayBirthdays, filterUpcomingBirthdays;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        Colors,
        Column,
        Icon,
        Icons,
        Padding,
        Scaffold,
        SizedBox,
        Text,
        TextStyle,
        Theme,
        Widget;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValueExtensions, ConsumerWidget, WidgetRef;
import 'package:logkeeper/logkeeper.dart' show LogKeeper;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: .all(25.0),
          child: ref
              .watch(birthdaysListProvider)
              .when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, stackTrace) {
                  LogKeeper.error('Error loading birthdays: $e');
                  LogKeeper.error('StackTrace: $stackTrace');

                  return Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.getting_birthdays_error,
                      ),
                    ],
                  );
                },

                data: (data) {
                  if (data.isEmpty) {
                    return Column(
                      mainAxisAlignment: .center,
                      children: [
                        const Icon(
                          Icons.cake_outlined,
                          color: Colors.grey,
                          size: 40,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.empty_birthdays_error,
                          textAlign: .center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    );
                  }

                  final todayBirthdays = filterTodayBirthdays(data);
                  final upcomingBirthdays = filterUpcomingBirthdays(data);

                  return Column(
                    mainAxisAlignment: .center,
                    children: [
                      SectionTitle(
                        text: AppLocalizations.of(
                          context,
                        )!.today_birthdays_section_title,
                        fontSize: 13,
                      ),

                      if (todayBirthdays.isEmpty)
                        Text(
                          AppLocalizations.of(context)!.no_birthdays_today,
                          textAlign: .center,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        )
                      else
                        ...todayBirthdays.map(
                          (b) => GradientCard(
                            child: ReminderCard(
                              id: b.id,
                              contactInfo: b.contactInfo,
                              notificationScheduled: b.notificationScheduled,
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),

                      SectionTitle(
                        text: AppLocalizations.of(
                          context,
                        )!.upcoming_birthdays_section_title,
                        fontSize: 13,
                      ),

                      if (upcomingBirthdays.isEmpty)
                        Column(
                          children: [
                            const Icon(
                              Icons.cake_outlined,
                              color: Colors.grey,
                              size: 36,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.no_upcoming_birthdays,
                              textAlign: .center,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        )
                      else
                        for (int i = 0; i < upcomingBirthdays.length; i++) ...[
                          ReminderCard(
                            id: upcomingBirthdays[i].id,
                            contactInfo: upcomingBirthdays[i].contactInfo,
                            notificationScheduled:
                                upcomingBirthdays[i].notificationScheduled,
                          ),
                          if (i < upcomingBirthdays.length - 1)
                            const SizedBox(height: 8),
                        ],
                    ],
                  );
                },
              ),
        ),
      ),
      floatingActionButton: const CreateBirthdayButton(),
    );
  }
}
