import 'package:equatable/equatable.dart';
import 'package:yala/domain/model/user.dart';

class DataAuth extends Equatable {
  final String accessToken;
  final String refreshToken;
  final User? user;

  const DataAuth({
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  bool isValidated() {
    return accessToken.isNotEmpty && refreshToken.isNotEmpty && (user?.id.isNotEmpty ?? false);
  }

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    user,
  ];
}
