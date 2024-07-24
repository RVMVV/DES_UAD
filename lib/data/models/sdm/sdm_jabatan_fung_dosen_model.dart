// To parse this JSON data, do
//
//     final jabatanFungsionalDosenModel = jabatanFungsionalDosenModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

JabatanFungsionalDosenModel jabatanFungsionalDosenModelFromJson(String str) =>
    JabatanFungsionalDosenModel.fromJson(json.decode(str));

String jabatanFungsionalDosenModelToJson(JabatanFungsionalDosenModel data) =>
    json.encode(data.toJson());

class JabatanFungsionalDosenModel {
  bool status;
  List<DataJabatanFungsionalDosen> data;
  String code;
  String message;

  JabatanFungsionalDosenModel({
    required this.status,
    required this.data,
    required this.code,
    required this.message,
  });

  factory JabatanFungsionalDosenModel.fromJson(Map<String, dynamic> json) =>
      JabatanFungsionalDosenModel(
        status: json["status"],
        data: List<DataJabatanFungsionalDosen>.from(
            json["data"].map((x) => DataJabatanFungsionalDosen.fromJson(x))),
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

class DataJabatanFungsionalDosen {
  String jabfungKode;
  String jabfungTendik;
  String persentase;
  String total;

  DataJabatanFungsionalDosen({
    required this.jabfungKode,
    required this.jabfungTendik,
    required this.persentase,
    required this.total,
  });

  factory DataJabatanFungsionalDosen.fromJson(Map<String, dynamic> json) =>
      DataJabatanFungsionalDosen(
        jabfungKode: json["jabfung_kode"],
        jabfungTendik: json["jabfung_tendik"],
        persentase: json["persentase"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "jabfung_tendik": jabfungTendik,
        "persentase": persentase,
        "total": total,
      };
}
