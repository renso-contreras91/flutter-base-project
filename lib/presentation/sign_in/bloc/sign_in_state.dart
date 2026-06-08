part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  final bool isLoading;
  final String? email;
  final String? password;
  final bool isChecked;
  final UiText? uiText;
  final SignInNavigation? signInNavigation;

  const SignInState({
    this.isLoading = false,
    this.email,
    this.password,
    this.isChecked = false,
    this.uiText,
    this.signInNavigation,
  });

  SignInState copyWith({
    Object? isLoading = unset,
    Object? email = unset,
    Object? password = unset,
    Object? isChecked = unset,
    UiText? uiText, // default null, siempre se resetea
    SignInNavigation? signInNavigation, // default null, siempre se resetea
  }) {
    return SignInState(
      isLoading: isLoading is Unset ? this.isLoading : isLoading as bool,
      email: email is Unset ? this.email : email as String?,
      password: password is Unset ? this.password : password as String?,
      isChecked: isChecked is Unset ? this.isChecked : isChecked as bool,
      uiText: uiText,
      signInNavigation: signInNavigation,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    email,
    password,
    isChecked,
    uiText,
    signInNavigation,
  ];
}
