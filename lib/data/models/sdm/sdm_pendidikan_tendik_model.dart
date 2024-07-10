// To parse this JSON data, do
//
//     final pendidikanTendikModel = pendidikanTendikModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PendidikanTendikModel pendidikanTendikModelFromJson(String str) => PendidikanTendikModel.fromJson(json.decode(str));

String pendidikanTendikModelToJson(PendidikanTendikModel data) => json.encode(data.toJson());

class PendidikanTendikModel {
    bool status;
    List<DataPendidikanTendik> data;
    String code;
    String message;

    PendidikanTendikModel({
        required this.status,
        required this.data,
        required this.code,
        required this.message,
    });

    factory PendidikanTendikModel.fromJson(Map<String, dynamic> json) => PendidikanTendikModel(
        status: json["status"],
        data: List<DataPendidikanTendik>.from(json["data"].map((x) => DataPendidikanTendik.fromJson(x))),
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

class DataPendidikanTendik {
    String pendTendik;
    String persentase;
    String total;

    DataPendidikanTendik({
        required this.pendTendik,
        required this.persentase,
        required this.total,
    });

    factory DataPendidikanTendik.fromJson(Map<String, dynamic> json) => DataPendidikanTendik(
        pendTendik: json["pend_tendik"],
        persentase: json["persentase"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "pend_tendik": pendTendik,
        "persentase": persentase,
        "total": total,
    };
}
