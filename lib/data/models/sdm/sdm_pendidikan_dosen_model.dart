// To parse this JSON data, do
//
//     final pendidikanDosenModel = pendidikanDosenModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PendidikanDosenModel pendidikanDosenModelFromJson(String str) => PendidikanDosenModel.fromJson(json.decode(str));

String pendidikanDosenModelToJson(PendidikanDosenModel data) => json.encode(data.toJson());

class PendidikanDosenModel {
    bool status;
    List<DataPendidikanDosen> data;
    String code;
    String message;

    PendidikanDosenModel({
        required this.status,
        required this.data,
        required this.code,
        required this.message,
    });

    factory PendidikanDosenModel.fromJson(Map<String, dynamic> json) => PendidikanDosenModel(
        status: json["status"],
        data: List<DataPendidikanDosen>.from(json["data"].map((x) => DataPendidikanDosen.fromJson(x))),
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

class DataPendidikanDosen {
  final String pendDosen;
  final String persentase;
  final String total;

  DataPendidikanDosen({
    required this.pendDosen,
    required this.persentase,
    required this.total,
  });

  factory DataPendidikanDosen.fromJson(Map<String, dynamic> json) {
    return DataPendidikanDosen(
      pendDosen: json['pend_dosen'],
      persentase: json['persentase'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pend_dosen': pendDosen,
      'persentase': persentase,
      'total': total,
    };
  }
}
