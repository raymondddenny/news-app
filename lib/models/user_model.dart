// * BASE API https://reqres.in/api/users/3

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required Data data,
    required Support? support,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
class Data with _$Data {
  factory Data({
    required int id,
    required String email,
    // note: using a JsonKey to map our JSON key that uses
    // *snake_case* to our Dart variable that uses *camelCase*
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? avatar,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class Support with _$Support {
  factory Support({
    String? url,
    String? text,
  }) = _Support;

  factory Support.fromJson(Map<String, dynamic> json) => _$SupportFromJson(json);
}
