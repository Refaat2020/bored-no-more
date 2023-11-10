import 'package:date_format/date_format.dart';

class DateHelper {

  String formatDateStringWithDash(DateTime date) {
    final formatted = formatDate(date, [yyyy, '-', mm, '-', dd," ",HH, ':', nn]);
    return formatted;
  }


}

