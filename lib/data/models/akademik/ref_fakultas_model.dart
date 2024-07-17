// To parse this JSON data, do
//
//     final refFakultas = refFakultasFromJson(jsonString);

import 'dart:convert';

RefFakultas refFakultasFromJson(String str) =>
    RefFakultas.fromJson(json.decode(str));

String refFakultasToJson(RefFakultas data) => json.encode(data.toJson());

class RefFakultas {
  bool status;
  List<RefFak> data;
  String code;
  String message;

  RefFakultas({
    required this.status,
    required this.data,
    required this.code,
    required this.message,
  });

  factory RefFakultas.fromJson(Map<String, dynamic> json) => RefFakultas(
        status: json["status"],
        data: List<RefFak>.from(json["data"].map((x) => RefFak.fromJson(x))),
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

class RefFak {
  String fakultas;
  String fakKode;

  RefFak({
    required this.fakultas,
    required this.fakKode,
  });

  factory RefFak.fromJson(Map<String, dynamic> json) => RefFak(
        fakultas: json["fakultas"],
        fakKode: json["fak_kode"],
      );

  Map<String, dynamic> toJson() => {
        "fakultas": fakultas,
        "fak_kode": fakKode,
      };
}
