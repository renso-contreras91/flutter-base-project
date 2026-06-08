import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yala/common/constants/app_colors.dart';
import 'package:yala/common/constants/app_images.dart';
import 'package:yala/common/constants/app_dimens.dart';
import 'package:yala/common/routes/app_routes.dart';
import 'package:yala/di/setup_locator.dart';
import 'package:yala/domain/usecases/preference/preference_use_case.dart';
import 'package:yala/presentation/launcher/bloc/launcher_bloc.dart';
import 'package:yala/presentation/launcher/bloc/launcher_event.dart';
import 'package:yala/presentation/launcher/bloc/launcher_state.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LauncherBloc(locator<PreferenceUseCases>()),
      child: const LauncherView(),
    );
  }
}

class LauncherView extends StatefulWidget {
  const LauncherView({super.key});

  @override
  State<LauncherView> createState() => _LauncherViewState();
}

class _LauncherViewState extends State<LauncherView> {
  @override
  void initState() {
    super.initState(); // siempre primero
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LauncherBloc>().add(const LauncherInitEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return BlocListener<LauncherBloc, LauncherState>(
      listenWhen: (_, current) => current.status == LauncherStatus.ready,
      listener: (context, state) {
        if (state.user != null) {
          context.go(AppRoutes.dashboard);
        } else {
          context.go(AppRoutes.signIn);
        }
      },
      child: Container(
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        color: AppColors.primary,
        alignment: Alignment.center,
        child: Image.asset(
          AppImages.IC_YALA,
          height: AppIcon.launcher,
        ),
      ),
    );
  }
}
