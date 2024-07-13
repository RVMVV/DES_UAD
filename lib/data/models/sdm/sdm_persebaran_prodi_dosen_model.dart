// To parse this JSON data, do
//
//     final sdmPersebaranProdiDosenModel = sdmPersebaranProdiDosenModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SdmPersebaranProdiDosenModel sdmPersebaranProdiDosenModelFromJson(String str) => SdmPersebaranProdiDosenModel.fromJson(json.decode(str));

String sdmPersebaranProdiDosenModelToJson(SdmPersebaranProdiDosenModel data) => json.encode(data.toJson());

class SdmPersebaranProdiDosenModel {
    bool status;
    List<DataPersebaranProdiDosen> data;
    String code;
    String message;

    SdmPersebaranProdiDosenModel({
        required this.status,
        required this.data,
        required this.code,
        required this.message,
    });

    factory SdmPersebaranProdiDosenModel.fromJson(Map<String, dynamic> json) => SdmPersebaranProdiDosenModel(
        status: json["status"],
        data: List<DataPersebaranProdiDosen>.from(json["data"].map((x) => DataPersebaranProdiDosen.fromJson(x))),
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

class DataPersebaranProdiDosen {
    String fakultas;
    String prodi;
    String persentase;
    String total;

    DataPersebaranProdiDosen({
        required this.fakultas,
        required this.prodi,
        required this.persentase,
        required this.total,
    });

    factory DataPersebaranProdiDosen.fromJson(Map<String, dynamic> json) => DataPersebaranProdiDosen(
        fakultas: json["fakultas"],
        prodi: json["prodi"],
        persentase: json["persentase"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "fakultas": fakultas,
        "prodi": prodi,
        "persentase": persentase,
        "total": total,
    };
}
