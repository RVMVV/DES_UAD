import 'dart:convert';

LogIn logInFromJson(String str) => LogIn.fromJson(json.decode(str));

class LogIn {
  bool status;
  Data data;
  String code;
  String message;

  LogIn({
    required this.status,
    required this.data,
    required this.code,
    required this.message,
  });

  factory LogIn.fromJson(Map<String, dynamic> json) => LogIn(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        code: json["code"],
        message: json["message"],
      );
}

class Data {
  String userId;
  String userEmail;
  String userRole;
  String accessToken;
  String expiredTime;
  // String kodeUnit;
  // String refreshToken;

  Data({
    required this.userId,
    required this.userEmail,
    required this.userRole,
    required this.accessToken,
    required this.expiredTime,
    // required this.kodeUnit,
    // required this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        userEmail: json["user_email"] ?? '',
        userRole: json["user_role"],
        accessToken: json["access_token"],
        expiredTime: json["expired_time"],
        // kodeUnit: json["unit_kode"] ?? '',
        // refreshToken: json["refresh_token"],
      );
}
