class MessageModel {
  dynamic datetime;
  String text;
  String name;
  String time;
  String uID;

  MessageModel({
    this.datetime,
    this.uID,
    this.text,
    this.name,
    this.time,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uID = json['uID'];
    datetime = json['datetime'];
    text = json['text'];
    time = json['timeo'];
  }

  Map<String, dynamic> ToMap() {
    return {
      'name': name,
      'uID': uID,
      'datetime': datetime,
      'text': text,
      'timeo': time,
    };
  }
}
