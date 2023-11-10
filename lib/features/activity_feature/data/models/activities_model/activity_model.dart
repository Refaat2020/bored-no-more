class ActivityModel{
String ?activity;
String ?accessibility;
String ?type;
String ?price;

ActivityModel({this.activity, this.accessibility, this.type, this.price});

factory ActivityModel.fromMap(dynamic map) {
    var temp;
    return ActivityModel(
      activity: map['activity']?.toString(),
      accessibility: map['accessibility']?.toString(),
      type: map['type']?.toString(),
      price: map['price']?.toString(),
    );
  }

Map<String, dynamic> toMap() {
    return {
      'activity': activity,
      'accessibility': accessibility,
      'type': type,
      'price': price,
    };
  }
}