import 'package:cakeday/types/birthday_data.dart' show BirthdayData;

class BirthdayItem extends _RenderItem {
  final BirthdayData data;

  BirthdayItem(this.data);
}

class HeaderItem extends _RenderItem {
  final String title;

  HeaderItem(this.title);
}

sealed class _RenderItem {}
