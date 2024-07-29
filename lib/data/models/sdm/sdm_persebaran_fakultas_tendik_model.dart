// To parse this JSON data, do
//
//     final sdmPersebaranFakultasTendikModel = sdmPersebaranFakultasTendikModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SdmPersebaranFakultasTendikModel sdmPersebaranFakultasTendikModelFromJson(String str) => SdmPersebaranFakultasTendikModel.fromJson(json.decode(str));

String sdmPersebaranFakultasTendikModelToJson(SdmPersebaranFakultasTendikModel data) => json.encode(data.toJson());

class SdmPersebaranFakultasTendikModel {
    bool status;
    List<DataPersebaranFakultasTendik> data;
    String code;
    String message;

    SdmPersebaranFakultasTendikModel({
        required this.status,
        required this.data,
        required this.code,
        required this.message,
    });

    factory SdmPersebaranFakultasTendikModel.fromJson(Map<String, dynamic> json) => SdmPersebaranFakultasTendikModel(
        status: json["status"],
        data: List<DataPersebaranFakultasTendik>.from(json["data"].map((x) => DataPersebaranFakultasTendik.fromJson(x))),
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

class DataPersebaranFakultasTendik {
    String fakultas;
    String prodi;
    String persentase;
    String total;

    DataPersebaranFakultasTendik({
        required this.fakultas,
        required this.prodi,
        required this.persentase,
        required this.total,
    });

    factory DataPersebaranFakultasTendik.fromJson(Map<String, dynamic> json) => DataPersebaranFakultasTendik(
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
