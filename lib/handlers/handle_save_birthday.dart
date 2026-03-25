import 'package:cakeday/types/contacts.dart';
import 'package:cakeday/utils/toast.dart';

Future<void> handleSaveBirthday({
  required ContactInfo? contactInfo,
  required DateTime? birthday,
}) async {
  try {
    if (contactInfo == null) {
      showToast(
        type: .error,
        msg: 'Please select a contact from your contact list ',
      );

      return;
    }

    if (contactInfo.$2 == null) {
      showToast(
        type: .error,
        msg:
            'We were unable to retrieve the number for the selected contact. Please try again later.',
      );

      return;
    }

    if (birthday == null) {
      showToast(type: .error, msg: 'Please select the birthday');

      return;
    }

    print('Saving birthday...');
    showToast(type: .success, msg: 'Birthday saved successfully');
  } catch (e) {
    print(e);
    showToast(
      type: .error,
      msg: 'We were unable to save the birthday; please try again later',
    );
  }
}
