import 'package:yala/domain/model/data_auth.dart';
import 'package:yala/domain/model/user.dart';

class DataAuthDto {
  final String accessToken;
  final String refreshToken;
  final User? user;

  const DataAuthDto({
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  factory DataAuthDto.fromJson(Map<String, dynamic> json) => DataAuthDto(
    accessToken: json["accessToken"] ?? '',
    refreshToken: json["refreshToken"] ?? '',
    user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
  );

  DataAuth toDomain() => DataAuth(
    accessToken: accessToken,
    refreshToken: refreshToken,
    user: user,
  );
}
