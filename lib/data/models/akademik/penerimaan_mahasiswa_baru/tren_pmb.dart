// To parse this JSON data, do
//
//     final trenPmb = trenPmbFromJson(jsonString);

import 'dart:convert';

TrenPmb trenPmbFromJson(String str) => TrenPmb.fromJson(json.decode(str));

class TrenPmb {
  bool status;
  // List<Waktu> data;
  List<Hari> data;
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
        // data: List<Waktu>.from(json["data"].map((x) => Waktu.fromJson(x))),
        data: List<Hari>.from(json["data"].map((x) => Hari.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );
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

class Hari {
  String hari;
  String tanggal;
  String jumlah;

  Hari({
    required this.hari,
    required this.tanggal,
    required this.jumlah,
  });

  factory Hari.fromJson(Map<String, dynamic> json) => Hari(
        hari: json["hari"],
        tanggal: json["tanggal"],
        jumlah: json["jumlah"],
      );
}
