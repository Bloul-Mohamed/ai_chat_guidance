// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseBody _$LoginResponseBodyFromJson(Map<String, dynamic> json) =>
    LoginResponseBody(
      expirationDate: json['expirationDate'] as String?,
      token: json['token'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      uuid: json['uuid'] as String?,
      idIndividu: (json['idIndividu'] as num?)?.toInt(),
      etablissementId: (json['etablissementId'] as num?)?.toInt(),
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$LoginResponseBodyToJson(LoginResponseBody instance) =>
    <String, dynamic>{
      'expirationDate': instance.expirationDate,
      'token': instance.token,
      'userId': instance.userId,
      'uuid': instance.uuid,
      'idIndividu': instance.idIndividu,
      'etablissementId': instance.etablissementId,
      'userName': instance.userName,
    };
