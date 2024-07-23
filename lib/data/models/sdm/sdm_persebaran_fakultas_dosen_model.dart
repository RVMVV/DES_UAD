// To parse this JSON data, do
//
//     final sdmPersebaranFakultasDosenModel = sdmPersebaranFakultasDosenModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SdmPersebaranFakultasDosenModel sdmPersebaranFakultasDosenModelFromJson(String str) => SdmPersebaranFakultasDosenModel.fromJson(json.decode(str));

String sdmPersebaranFakultasDosenModelToJson(SdmPersebaranFakultasDosenModel data) => json.encode(data.toJson());

class SdmPersebaranFakultasDosenModel {
    bool status;
    List<dataPersebaranFakultasDosen> data;
    String code;
    String message;

    SdmPersebaranFakultasDosenModel({
        required this.status,
        required this.data,
        required this.code,
        required this.message,
    });

    factory SdmPersebaranFakultasDosenModel.fromJson(Map<String, dynamic> json) => SdmPersebaranFakultasDosenModel(
        status: json["status"],
        data: List<dataPersebaranFakultasDosen>.from(json["data"].map((x) => dataPersebaranFakultasDosen.fromJson(x))),
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

class dataPersebaranFakultasDosen {
    String fakultas;
    String prodi;
    String persentase;
    String total;

    dataPersebaranFakultasDosen({
        required this.fakultas,
        required this.prodi,
        required this.persentase,
        required this.total,
    });

    factory dataPersebaranFakultasDosen.fromJson(Map<String, dynamic> json) => dataPersebaranFakultasDosen(
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
