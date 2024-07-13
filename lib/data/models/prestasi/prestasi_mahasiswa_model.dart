import 'dart:convert';

PrestasiMahasiswa prestasiMahasiswaFromJson(String str) =>
    PrestasiMahasiswa.fromJson(json.decode(str));

class PrestasiMahasiswa {
  bool status;
  List<DataPrestasiMhs> data;
  String code;
  String message;

  PrestasiMahasiswa({
    required this.status,
    required this.data,
    required this.code,
    required this.message,
  });

  factory PrestasiMahasiswa.fromJson(Map<String, dynamic> json) =>
      PrestasiMahasiswa(
        status: json["status"],
        data: List<DataPrestasiMhs>.from(
            json["data"].map((x) => DataPrestasiMhs.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );
}

class DataPrestasiMhs {
  String tahun;
  String cakupanIntrnsl;
  String cakupanNsl;
  String cakupanLkl;
  String mhsBerprestasi;
  String score;

  DataPrestasiMhs({
    required this.tahun,
    required this.cakupanIntrnsl,
    required this.cakupanNsl,
    required this.cakupanLkl,
    required this.mhsBerprestasi,
    required this.score,
  });

  factory DataPrestasiMhs.fromJson(Map<String, dynamic> json) =>
      DataPrestasiMhs(
        tahun: json["tahun"],
        cakupanIntrnsl: json["cakupan_intrnsl"],
        cakupanNsl: json["cakupan_nsl"],
        cakupanLkl: json["cakupan_lkl"],
        mhsBerprestasi: json["mhs_berprestasi"],
        score: json["score"],
      );
}
