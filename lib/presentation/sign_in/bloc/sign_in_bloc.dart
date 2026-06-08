import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yala/common/constants/app_constants.dart';
import 'package:yala/common/extension/app_failure.dart';
import 'package:yala/domain/either/result.dart';
import 'package:yala/domain/model/data_auth.dart';
import 'package:yala/domain/model/ui_text.dart';
import 'package:yala/domain/model/unset.dart';
import 'package:yala/domain/usecases/auth/sign_in_use_cases.dart';
import 'package:yala/domain/usecases/preference/preference_use_case.dart';
import 'package:yala/presentation/sign_in/navigation/sign_in_navigation.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase _signInUseCase;
  final PreferenceUseCases _preferenceUseCases;

  SignInBloc(
    this._signInUseCase,
    this._preferenceUseCases,
  ) : super(const SignInState()) {
    on<SignInInitEvent>(_onSignInInitEvent);
    on<SignInEmailChanged>(_onSignInEmailChanged);
    on<SignInPasswordChanged>(_onSignInPasswordChanged);
    on<SignInIsRememberChanged>(_onSignInIsRememberChanged);
    on<SignInSubmit>(_onSubmit);
    on<SignInFormReset>(_onFormReset);
  }

  FutureOr<void> _onSignInInitEvent(
    SignInInitEvent event,
    Emitter<SignInState> emit,
  ) async {
    final bool isRememberAccount = await _preferenceUseCases.preference.isRememberAccount();
    if (isRememberAccount) {
      final String email = await _preferenceUseCases.preference.getEmail();
      emit(
        state.copyWith(
          email: email,
          password: null,
          isChecked: isRememberAccount,
        ),
      );
    }
  }

  FutureOr<void> _onSignInEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  FutureOr<void> _onSignInPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  FutureOr<void> _onSignInIsRememberChanged(
    SignInIsRememberChanged event,
    Emitter<SignInState> emit,
  ) {
    emit(
      state.copyWith(
        isChecked: event.isChecked,
      ),
    );
  }

  FutureOr<void> _onSubmit(
    SignInSubmit event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final signInResult = await _signInUseCase.run(
      email: state.email!,
      password: state.password!,
    );
    switch (signInResult) {
      case Success<DataAuth>():
        {
          final dataAuth = signInResult.response!;
          await _preferenceUseCases.preference.saveRememberAccount(
            isChecked: state.isChecked,
          );
          if (state.isChecked) {
            await _preferenceUseCases.preference.saveEmail(
              email: state.email!,
            );
          } else {
            await _preferenceUseCases.preference.saveEmail(
              email: AppConstants.EMPTY_STRING,
            );
          }
          await _preferenceUseCases.preference.saveAccessToken(
            token: dataAuth.accessToken,
          );
          await _preferenceUseCases.preference.saveRefreshToken(
            token: dataAuth.refreshToken,
          );
          await _preferenceUseCases.preference.saveUser(
            user: dataAuth.user!,
          );
          emit(
            state.copyWith(
              isLoading: false,
              signInNavigation: const GoToHome(),
            ),
          );
        }

      case Failure<DataAuth>():
        {
          emit(
            state.copyWith(
              isLoading: false,
              uiText: signInResult.appFailure.toUiText(),
            ),
          );
        }
    }
  }

  FutureOr<void> _onFormReset(
    SignInFormReset event,
    Emitter<SignInState> emit,
  ) {
    emit(
      const SignInState(),
    );
  }
}
