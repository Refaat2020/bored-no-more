import 'package:bored_no_more/core/services/date_helper.dart';

class PlannedActivity{

  String ?activityName;
  String? activityDate;
  bool? saveActivityEncrypted;

  PlannedActivity({this.activityName, this.activityDate,this.saveActivityEncrypted});


  factory PlannedActivity.fromMap(dynamic map) {
    var temp;
    return PlannedActivity(
      activityName: map['activityName']?.toString(),
      activityDate: DateHelper().formatDateStringWithDash(DateTime.parse( map['activityDate']!.toString())),
      saveActivityEncrypted: null == (temp = map['saveActivityEncrypted'])
          ? null
          : (temp is bool
              ? temp
              : (temp is num
                  ? 0 != temp.toInt()
                  : ('true' == temp.toString()))),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'activityName': activityName,
      'activityDate': activityDate,
      "saveActivityEncrypted":saveActivityEncrypted
    };
  }
}