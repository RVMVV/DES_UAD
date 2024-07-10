// To parse this JSON data, do
//
//     final jabatanFungsionalTendikModel = jabatanFungsionalTendikModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

JabatanFungsionalTendikModel jabatanFungsionalTendikModelFromJson(String str) => JabatanFungsionalTendikModel.fromJson(json.decode(str));

String jabatanFungsionalTendikModelToJson(JabatanFungsionalTendikModel data) => json.encode(data.toJson());

class JabatanFungsionalTendikModel {
    bool status;
    List<DataJabatanFungsionalTendik> data;
    String code;
    String message;

    JabatanFungsionalTendikModel({
        required this.status,
        required this.data,
        required this.code,
        required this.message,
    });

    factory JabatanFungsionalTendikModel.fromJson(Map<String, dynamic> json) => JabatanFungsionalTendikModel(
        status: json["status"],
        data: List<DataJabatanFungsionalTendik>.from(json["data"].map((x) => DataJabatanFungsionalTendik.fromJson(x))),
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

class DataJabatanFungsionalTendik {
    String jabfungTendik;
    String persentase;
    String total;

    DataJabatanFungsionalTendik({
        required this.jabfungTendik,
        required this.persentase,
        required this.total,
    });

    factory DataJabatanFungsionalTendik.fromJson(Map<String, dynamic> json) => DataJabatanFungsionalTendik(
        jabfungTendik: json["jabfung_tendik"],
        persentase: json["persentase"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "jabfung_tendik": jabfungTendik,
        "persentase": persentase,
        "total": total,
    };
}
