// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Password _$PasswordFromJson(Map<String, dynamic> json) {
  return Password()
    ..id = json['id'] as num
    ..title = json['title'] as String
    ..accont = json['accont'] as String
    ..password = json['password'] as String
    ..remark = json['remark'] as String
    ..createdTime = json['createdTime'] as String
    ..updateTime = json['updateTime'] as String
    ..last = json['last'] as String;
}

Map<String, dynamic> _$PasswordToJson(Password instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'accont': instance.accont,
      'password': instance.password,
      'remark': instance.remark,
      'createdTime': instance.createdTime,
      'updateTime': instance.updateTime,
      'last': instance.last
    };
