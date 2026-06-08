part of 'sign_in_bloc.dart';

sealed class SignInEvent {
  const SignInEvent();
}

class SignInInitEvent extends SignInEvent {
  const SignInInitEvent();
}

class SignInEmailChanged extends SignInEvent {
  final String email;

  const SignInEmailChanged({
    required this.email,
  });
}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  const SignInPasswordChanged({
    required this.password,
  });
}

class SignInIsRememberChanged extends SignInEvent {
  final bool isChecked;

  const SignInIsRememberChanged({
    required this.isChecked,
  });
}

class SignInSubmit extends SignInEvent {}

class SignInFormReset extends SignInEvent {}
