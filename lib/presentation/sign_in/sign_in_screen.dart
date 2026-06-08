import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yala/common/constants/app_constants.dart';
import 'package:yala/common/constants/app_dimens.dart';
import 'package:yala/common/constants/app_images.dart';
import 'package:yala/common/enum/enums.dart';
import 'package:yala/common/extension/string_extensions.dart';
import 'package:yala/common/form/sign_in_validations.dart';
import 'package:yala/common/routes/app_routes.dart';
import 'package:yala/di/setup_locator.dart';
import 'package:yala/domain/usecases/auth/sign_in_use_cases.dart';
import 'package:yala/domain/usecases/preference/preference_use_case.dart';
import 'package:yala/l10n/app_localizations.dart';
import 'package:yala/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:yala/presentation/sign_in/navigation/sign_in_navigation.dart';
import 'package:yala/presentation/widgets/custom_button.dart';
import 'package:yala/presentation/widgets/custom_loading.dart';
import 'package:yala/presentation/widgets/custom_text_fields.dart';
import 'package:yala/presentation/widgets/snack_bar_animation.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        locator<SignInUseCase>(),
        locator<PreferenceUseCases>(),
      ),
      child: const SignInScreenView(),
    );
  }
}

class SignInScreenView extends StatefulWidget {
  const SignInScreenView({super.key});

  @override
  State<SignInScreenView> createState() => _SignInScreenViewState();
}

class _SignInScreenViewState extends State<SignInScreenView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return PopScope(
      canPop: false, // ← bloquea el pop normal
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Cierra la app en lugar de hacer pop
          SystemNavigator.pop();
        }
      },
      child: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.uiText != null) {
            showMessage(
              context: context,
              message: state.uiText!.resolve(AppLocalizations.of(context)!),
              type: SnackbarEnum.error,
            );
          }
          switch (state.signInNavigation) {
            case GoToHome():
              context.go(AppRoutes.dashboard);
            default:
              break;
          }
        },
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: SafeArea(
                  child: SizedBox(
                    width: mediaQueryData.size.width,
                    height: mediaQueryData.size.height,
                    child: _body(
                      mediaQueryData,
                    ),
                  ),
                ),
              ),
              BlocBuilder<SignInBloc, SignInState>(
                buildWhen: (previous, current) {
                  return previous.isLoading != current.isLoading;
                },
                builder: (context, state) {
                  return state.isLoading == true
                      ? const CustomLoading(
                          isTransparent: true,
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(
    MediaQueryData mediaQueryData,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: mediaQueryData.size.height * 0.12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageYala(),
              _textFieldEmail(
                context,
                l10n,
              ),
              const SizedBox(
                height: AppSpacing.sm,
              ),
              _textFieldPassword(
                context,
                l10n,
              ),
              const SizedBox(
                height: AppSpacing.sm,
              ),
              _rememberMe(
                context,
                l10n,
              ),
              const SizedBox(
                height: AppSpacing.xl,
              ),
              _buttonSubmit(
                context,
                l10n,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageYala() {
    return Image.asset(
      AppImages.IC_YALA,
      height: AppIcon.logo,
    );
  }

  Widget _textFieldEmail(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return BlocConsumer<SignInBloc, SignInState>(
      buildWhen: (previous, current) {
        return previous.email != current.email;
      },
      listener: (context, state) {
        final email = state.email.orEmpty();
        final text = _emailController.text;
        if (email != text) {
          _emailController.text = email;
          _emailController.selection = TextSelection.collapsed(
            offset: email.length,
          );
        }
      },
      builder: (context, state) {
        return CustomTextField(
          textTitle: l10n.email,
          messageError: l10n.enterEmail,
          inputTypeEnum: InputTypeEnum.ALL,
          isError: state.email != null && SignInValidations.emailHasError(state.email),
          onValueChange: (text) {
            context.read<SignInBloc>().add(
              SignInEmailChanged(
                email: text,
              ),
            );
          },
          textEditingController: _emailController,
        );
      },
    );
  }

  Widget _textFieldPassword(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        final password = state.password.orEmpty();
        final text = _passwordController.text;
        if (password != text) {
          _passwordController.text = password;
          _passwordController.selection = TextSelection.collapsed(
            offset: password.length,
          );
        }
      },
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return CustomTextField(
          textTitle: l10n.password,
          messageError: l10n.enterPasswordMinChars(AppConstants.MINIMUM_LENGTH_PASSWORD),
          inputTypeEnum: InputTypeEnum.PASSWORD,
          isError: state.password != null && SignInValidations.passwordHasError(state.password),
          onValueChange: (text) {
            context.read<SignInBloc>().add(
              SignInPasswordChanged(
                password: text,
              ),
            );
          },
          textEditingController: _passwordController,
        );
      },
    );
  }

  Widget _rememberMe(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) {
        return previous.isChecked != current.isChecked;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<SignInBloc>().add(
              SignInIsRememberChanged(isChecked: !state.isChecked),
            );
          },
          child: Row(
            children: [
              Checkbox(
                value: state.isChecked,
                onChanged: (_) {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // ← elimina el tap area extra
              ),
              Text(
                l10n.rememberMyAccount,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buttonSubmit(
    BuildContext context,
    AppLocalizations l10,
  ) {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) {
        return previous.email != current.email || previous.password != current.password;
      },
      builder: (context, state) {
        final isEnabled =
            !SignInValidations.emailHasError(state.email) && !SignInValidations.passwordHasError(state.password);
        return CustomButton(
          textValue: l10.enter,
          isEnabled: isEnabled,
          onClickBtn: () {
            context.read<SignInBloc>().add(
              SignInSubmit(),
            );
          },
        );
      },
    );
  }
}
