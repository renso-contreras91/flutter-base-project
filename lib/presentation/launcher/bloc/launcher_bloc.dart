import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yala/domain/model/user.dart';
import 'package:yala/domain/usecases/preference/preference_use_case.dart';
import 'package:yala/presentation/launcher/bloc/launcher_event.dart';
import 'package:yala/presentation/launcher/bloc/launcher_state.dart';

class LauncherBloc extends Bloc<LauncherEvent, LauncherState> {
  final PreferenceUseCases _preferenceUseCases;

  LauncherBloc(
    this._preferenceUseCases,
  ) : super(const LauncherState()) {
    on<LauncherInitEvent>(_onLauncherInitEvent);
  }

  FutureOr<void> _onLauncherInitEvent(
    LauncherInitEvent event,
    Emitter<LauncherState> emit,
  ) async {
    emit(
      state.copyWith(
        status: LauncherStatus.loading,
      ),
    );
    final User? user = await _preferenceUseCases.preference.getUser();
    await Future.delayed(const Duration(seconds: 2));
    emit(
      state.copyWith(
        status: LauncherStatus.ready,
        user: user,
      ),
    );
  }
}
