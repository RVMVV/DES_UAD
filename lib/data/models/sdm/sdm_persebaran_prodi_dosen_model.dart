// To parse this JSON data, do
//
//     final sdmPersebaranProdiDosenModel = sdmPersebaranProdiDosenModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SdmPersebaranProdiDosenModel sdmPersebaranProdiDosenModelFromJson(String str) => SdmPersebaranProdiDosenModel.fromJson(json.decode(str));


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

}
