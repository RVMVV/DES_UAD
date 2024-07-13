// To parse this JSON data, do
//
//     final sertifikasiProdiModel = sertifikasiProdiModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SertifikasiProdiModel sertifikasiProdiModelFromJson(String str) => SertifikasiProdiModel.fromJson(json.decode(str));

String sertifikasiProdiModelToJson(SertifikasiProdiModel data) => json.encode(data.toJson());

class SertifikasiProdiModel {
    bool status;
    List<DataSertifikasiProdi> data;
    String code;
    String message;

    SertifikasiProdiModel({
        required this.status,
        required this.data,
        required this.code,
        required this.message,
    });

    factory SertifikasiProdiModel.fromJson(Map<String, dynamic> json) => SertifikasiProdiModel(
        status: json["status"],
        data: List<DataSertifikasiProdi>.from(json["data"].map((x) => DataSertifikasiProdi.fromJson(x))),
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

class DataSertifikasiProdi {
    String prodi;
    String fakultas;
    String lembagaAkred;
    String masaBerlaku;

    DataSertifikasiProdi({
        required this.prodi,
        required this.fakultas,
        required this.lembagaAkred,
        required this.masaBerlaku,
    });

    factory DataSertifikasiProdi.fromJson(Map<String, dynamic> json) => DataSertifikasiProdi(
        prodi: json["prodi"],
        fakultas: json["fakultas"],
        lembagaAkred: json["lembaga_akred"],
        masaBerlaku: json["masa_berlaku"],
    );

    Map<String, dynamic> toJson() => {
        "prodi": prodi,
        "fakultas": fakultas,
        "lembaga_akred": lembagaAkred,
        "masa_berlaku": masaBerlaku,
    };
}
