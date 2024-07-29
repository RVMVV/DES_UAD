// To parse this JSON data, do
//
//     final trenPmb = trenPmbFromJson(jsonString);

import 'dart:convert';

TrenPmb trenPmbFromJson(String str) => TrenPmb.fromJson(json.decode(str));

String trenPmbToJson(TrenPmb data) => json.encode(data.toJson());

class TrenPmb {
  bool status;
  List<Waktu> data;
  String code;
  String message;

  TrenPmb({
    required this.status,
    required this.data,
    required this.code,
    required this.message,
  });

  factory TrenPmb.fromJson(Map<String, dynamic> json) => TrenPmb(
        status: json["status"],
        data: List<Waktu>.from(json["data"].map((x) => Waktu.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class Waktu {
  String jam;
  String jumlah;

  Waktu({
    required this.jam,
    required this.jumlah,
  });

  factory Waktu.fromJson(Map<String, dynamic> json) => Waktu(
        jam: json["jam"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "jam": jam,
        "jumlah": jumlah,
      };
}
