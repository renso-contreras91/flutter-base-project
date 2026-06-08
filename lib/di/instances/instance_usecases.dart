import 'package:yala/di/setup_locator.dart';
import 'package:yala/domain/preferences/preference.dart';
import 'package:yala/domain/repositories/auth_repository.dart';
import 'package:yala/domain/usecases/auth/sign_in_use_cases.dart';
import 'package:yala/domain/usecases/preference/preference_use_case.dart';

void instanceUseCases() {
  instancePreference();
  instanceAuthUseCases();
}

void instancePreference() {
  locator.registerSingleton<PreferenceUseCases>(
    PreferenceUseCases(
      preference: locator<Preference>(),
    ),
  );
}

void instanceAuthUseCases() {
  locator.registerSingleton<SignInUseCase>(
    SignInUseCase(
      locator<AuthRepository>(),
    ),
  );
}
