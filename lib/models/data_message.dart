import 'dart:convert';

DataMessage dataMessageFromMap(String str) =>
    DataMessage.fromMap(json.decode(str));

String dataMessageToMap(DataMessage data) => json.encode(data.toMap());

class DataMessage {
  DataMessage({
    this.success,
    this.data,
  });

  bool success;
  String data;

  factory DataMessage.fromMap(Map<String, dynamic> json) => DataMessage(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null ? null : data,
      };
}
