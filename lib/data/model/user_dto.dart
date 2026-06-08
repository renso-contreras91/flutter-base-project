import 'package:yala/domain/model/user.dart';

class UserDto {
  final String id;
  final String email;
  final String fullName;
  final String birthdate;
  final String countryCode;

  const UserDto({
    required this.id,
    required this.email,
    required this.fullName,
    required this.birthdate,
    required this.countryCode,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    id: json["id"] ?? '',
    email: json["email"] ?? '',
    fullName: json["name"] ?? '',
    birthdate: json["birthdate"] ?? '',
    countryCode: json["countryCode"] ?? '',
  );

  User toDomain() => User(
    id: id,
    email: email,
    fullName: fullName,
    birthdate: birthdate,
    countryCode: countryCode,
  );
}