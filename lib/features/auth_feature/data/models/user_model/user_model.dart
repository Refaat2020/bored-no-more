import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel{

  String?activity;
  String?userName;
  String?deviceId;
  String?age;
  bool?loginWithBio;
  DocumentReference<Map<String, dynamic>>? likedActivities;
  DocumentReference<Map<String, dynamic>>? plannedActivities;

  UserModel(
      {this.activity,
      this.userName,
      this.deviceId,
      this.age,
      this.loginWithBio,
        this.likedActivities,
        this.plannedActivities,
      });

  factory UserModel.fromMap(dynamic map) {
    var temp;
    return UserModel(
      activity: map['activity']?.toString(),
      userName: map['userName']?.toString(),
      deviceId: map['deviceId']?.toString(),
      age: map['age']?.toString(),
      loginWithBio: null == (temp = map['loginWithBio'])
          ? null
          : (temp is bool
              ? temp
              : (temp is num
                  ? 0 != temp.toInt()
                  : ('true' == temp.toString()))),
      likedActivities: map['LikedActivites'],
      plannedActivities: map['PlannedActivities'],
    );
  }
}