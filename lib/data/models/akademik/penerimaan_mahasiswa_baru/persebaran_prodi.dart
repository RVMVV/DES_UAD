import '../../persebaran_berdasarkan.dart';

class PersebaranProdi extends PersebaranBerdasarkan {
  final String prodi;

  PersebaranProdi({
    required this.prodi,
    required super.persentase,
    required super.total,
  });

  factory PersebaranProdi.fromJson(Map<String, dynamic> json) =>
      PersebaranProdi(
          prodi: json["prodi"],
          persentase: json["persentase"],
          total: json["total"]);

  Map<String, dynamic> toJson() => {
        "prodi": prodi,
        "persentase": persentase,
        "total": total,
      };
}
