// component_snackbar.dart
import 'package:flutter/material.dart';
import 'package:yala/common/constants/app_colors.dart';
import 'package:yala/common/constants/app_dimens.dart';
import 'package:yala/common/enum/enums.dart';
import 'package:yala/data/model/snackbar_style.dart';

class CustomSnackbar extends StatelessWidget {
  final String text;
  final SnackbarEnum snackbarEnum;
  final VoidCallback onDismiss;

  const CustomSnackbar({
    super.key,
    required this.text,
    required this.snackbarEnum,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final style = _toStyle(snackbarEnum);
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: style.bg,
          borderRadius: BorderRadius.circular(AppShape.rounded),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha : 0.12),
              blurRadius: AppElevation.snackbar,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              style.icon,
              color: style.fg,
              size: AppIcon.xs,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: style.fg,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close,
                color: style.fg,
                size: AppIcon.xxs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackbarStyle _toStyle(SnackbarEnum type) {
    return switch (type) {
      SnackbarEnum.success => const SnackbarStyle(
        bg: AppColors.success,
        fg: Colors.black,
        icon: Icons.check_circle,
      ),
      SnackbarEnum.error => const SnackbarStyle(
        bg: AppColors.error,
        fg: Colors.black,
        icon: Icons.error,
      ),
      SnackbarEnum.informative => const SnackbarStyle(
        bg: AppColors.informative,
        fg: Colors.black,
        icon: Icons.info,
      ),
    };
  }
}
