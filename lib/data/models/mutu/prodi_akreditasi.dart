import 'dart:convert';

ProdiAkreditasi prodiAkreditasiFromJson(String str) =>
    ProdiAkreditasi.fromJson(json.decode(str));

class ProdiAkreditasi {
  bool status;
  List<DataProdi> data;
  String code;
  String message;

  ProdiAkreditasi({
    required this.status,
    required this.data,
    required this.code,
    required this.message,
  });

  factory ProdiAkreditasi.fromJson(Map<String, dynamic> json) =>
      ProdiAkreditasi(
        status: json["status"],
        data: List<DataProdi>.from(
            json["data"].map((x) => DataProdi.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );
}

class DataProdi {
  String prodi;
  String fakultas;
  String lembagaAkred;
  String masaBerlaku;
  String color;

  DataProdi({
    required this.prodi,
    required this.fakultas,
    required this.lembagaAkred,
    required this.masaBerlaku,
    required this.color,
  });

  factory DataProdi.fromJson(Map<String, dynamic> json) => DataProdi(
        prodi: json["prodi"] ?? "",
        fakultas: json["fakultas"] ?? "",
        lembagaAkred: json["lembaga_akred"] ?? "",
        masaBerlaku: json["masa_berlaku"] ?? "",
        color: json["color"] ?? "",
      );
}
