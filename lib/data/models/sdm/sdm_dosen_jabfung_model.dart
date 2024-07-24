import 'dart:convert';

DosenJabfung dosenJabfungFromJson(String str) =>
    DosenJabfung.fromJson(json.decode(str));

String dosenJabfungToJson(DosenJabfung data) => json.encode(data.toJson());

class DosenJabfung {
  bool status;
  List<Dosen> data;
  String code;
  String message;

  DosenJabfung({
    required this.status,
    required this.data,
    required this.code,
    required this.message,
  });

  factory DosenJabfung.fromJson(Map<String, dynamic> json) => DosenJabfung(
        status: json["status"],
        data: List<Dosen>.from(json["data"].map((x) => Dosen.fromJson(x))),
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

class Dosen {
  String fakultas;
  String prodi;
  String dosen;

  Dosen({
    required this.fakultas,
    required this.prodi,
    required this.dosen,
  });

  factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
        fakultas: json["fakultas"],
        prodi: json["prodi"],
        dosen: json["dosen"],
      );

  Map<String, dynamic> toJson() => {
        "fakultas": fakultas,
        "prodi": prodi,
        "dosen": dosen,
      };
}
