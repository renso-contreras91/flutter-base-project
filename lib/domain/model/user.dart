import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String birthdate;
  final String countryCode;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.birthdate,
    required this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? '',
    email: json["email"] ?? '',
    fullName: json["fullName"] ?? '',
    birthdate: json["birthdate"] ?? '',
    countryCode: json["countryCode"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "fullName": fullName,
    "birthdate": birthdate,
    "countryCode": countryCode,
  };

  @override
  List<Object?> get props => [
    id,
    email,
    fullName,
    birthdate,
    countryCode,
  ];
}
