import 'package:json_annotation/json_annotation.dart';
part 'login_response_body.g.dart';

@JsonSerializable()
class LoginResponseBody {
  String? expirationDate;
  String? token;
  int? userId;
  String? uuid;
  int? idIndividu;
  int? etablissementId;
  String? userName;

  LoginResponseBody({
    this.expirationDate,
    this.token,
    this.userId,
    this.uuid,
    this.idIndividu,
    this.etablissementId,
    this.userName,
  });
  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);
}
