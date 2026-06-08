import 'package:equatable/equatable.dart';
import 'package:yala/domain/model/unset.dart';
import 'package:yala/domain/model/user.dart';

enum LauncherStatus { initial, loading, ready }

class LauncherState extends Equatable {
  final LauncherStatus status;
  final User? user;

  const LauncherState({
    this.status = LauncherStatus.initial,
    this.user,
  });

  LauncherState copyWith({
    Object? status = unset,
    Object? user = unset,
  }) {
    return LauncherState(
      status: status is Unset ? this.status : status as LauncherStatus,
      user: user is Unset ? this.user : user as User?,
    );
  }

  @override
  List<Object?> get props => [status, user];
}