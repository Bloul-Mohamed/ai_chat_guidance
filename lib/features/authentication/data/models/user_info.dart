import 'package:json_annotation/json_annotation.dart';
part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  String? dateNaissance;
  int? id;
  String? lieuNaissance;
  String? lieuNaissanceArabe;
  String? nomArabe;
  String? nomLatin;
  String? nss;
  String? prenomArabe;
  String? prenomLatin;

  UserInfo({
    this.dateNaissance,
    this.id,
    this.lieuNaissance,
    this.lieuNaissanceArabe,
    this.nomArabe,
    this.nomLatin,
    this.nss,
    this.prenomArabe,
    this.prenomLatin,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
