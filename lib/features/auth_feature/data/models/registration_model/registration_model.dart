class RegistrationModel{

  String?userName;
  int?age;
  String?activity;
  bool?loginWithBio;
  String?deviceId;

  RegistrationModel(
      {this.userName,
      this.age,
      this.activity,
      this.loginWithBio,
      this.deviceId});


  factory RegistrationModel.fromMap(dynamic map) {
    var temp;
    return RegistrationModel(
      userName: map['userName']?.toString(),
      age: null == (temp = map['age'])
          ? null
          : (temp is num ? temp.toInt() : int.tryParse(temp)),
      activity: map['activity']?.toString(),
      loginWithBio: null == (temp = map['loginWithBio'])
          ? null
          : (temp is bool
              ? temp
              : (temp is num
                  ? 0 != temp.toInt()
                  : ('true' == temp.toString()))),
      deviceId: map['deviceId']?.toString(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'age': age,
      'activity': activity,
      'loginWithBio': loginWithBio,
      'deviceId': deviceId,
    };
  }
}