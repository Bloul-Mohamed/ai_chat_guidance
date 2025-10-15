// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
  dateNaissance: json['dateNaissance'] as String?,
  id: (json['id'] as num?)?.toInt(),
  lieuNaissance: json['lieuNaissance'] as String?,
  lieuNaissanceArabe: json['lieuNaissanceArabe'] as String?,
  nomArabe: json['nomArabe'] as String?,
  nomLatin: json['nomLatin'] as String?,
  nss: json['nss'] as String?,
  prenomArabe: json['prenomArabe'] as String?,
  prenomLatin: json['prenomLatin'] as String?,
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'dateNaissance': instance.dateNaissance,
  'id': instance.id,
  'lieuNaissance': instance.lieuNaissance,
  'lieuNaissanceArabe': instance.lieuNaissanceArabe,
  'nomArabe': instance.nomArabe,
  'nomLatin': instance.nomLatin,
  'nss': instance.nss,
  'prenomArabe': instance.prenomArabe,
  'prenomLatin': instance.prenomLatin,
};
