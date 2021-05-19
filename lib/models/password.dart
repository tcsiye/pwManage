import 'package:json_annotation/json_annotation.dart';

part 'password.g.dart';

@JsonSerializable()
class Password {
    Password();

    num id;
    String title;
    String accont;
    String password;
    String remark;
    String createdTime;
    String updateTime;
    String last;
    
    factory Password.fromJson(Map<String,dynamic> json) => _$PasswordFromJson(json);
    Map<String, dynamic> toJson() => _$PasswordToJson(this);
}
