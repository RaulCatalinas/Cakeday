import 'package:cakeday/components/birthday/create_birthday_button.dart'
    show CreateBirthdayButton;
import 'package:cakeday/components/birthday/reminder_card.dart'
    show ReminderCard;
import 'package:cakeday/components/common/gradient_card.dart' show GradientCard;
import 'package:cakeday/components/common/section_title.dart' show SectionTitle;
import 'package:cakeday/db/db_manager.dart' show DbManager;
import 'package:cakeday/l10n/app_localizations.dart' show AppLocalizations;
import 'package:cakeday/types/contacts.dart' show ContactInfo;
import 'package:cakeday/utils/birthday_utils.dart'
    show filterTodayBirthdays, filterUpcomingBirthdays;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        Colors,
        Column,
        FutureBuilder,
        Icon,
        Icons,
        Padding,
        Scaffold,
        SizedBox,
        StatelessWidget,
        Text,
        TextStyle,
        Theme,
        Widget;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: .all(25.0),
          child: FutureBuilder(
            future: DbManager.getAllBirthdays(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == .waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.getting_birthdays_error),
                  ],
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
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

              final todayBirthdays = filterTodayBirthdays(snapshot.data!);
              final upcomingBirthdays = filterUpcomingBirthdays(snapshot.data!);

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
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    )
                  else
                    ...todayBirthdays.map(
                      (b) => GradientCard(
                        child: ReminderCard(
                          id: b.id,
                          contactInfo: ContactInfo(
                            name: b.name,
                            phone: b.phone,
                            photo: b.photo,
                            birthday: DateTime(b.year ?? 0, b.month, b.day),
                          ),
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
                          AppLocalizations.of(context)!.no_upcoming_birthdays,
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
                        contactInfo: ContactInfo(
                          name: upcomingBirthdays[i].name,
                          phone: upcomingBirthdays[i].phone,
                          photo: upcomingBirthdays[i].photo,
                          birthday: DateTime(
                            upcomingBirthdays[i].year ?? 0,
                            upcomingBirthdays[i].month,
                            upcomingBirthdays[i].day,
                          ),
                        ),
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
