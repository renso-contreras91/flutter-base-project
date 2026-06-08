import 'package:flutter/material.dart';
import 'package:yala/common/constants/app_colors.dart';

class CustomLoading extends StatelessWidget {
  final bool isTransparent;
  final double offsetProgressY;

  const CustomLoading({
    super.key,
    this.isTransparent = false,
    this.offsetProgressY = 0.0,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    final colors = isTransparent
        ? [Colors.transparent, Colors.transparent, scheme.outline]
        : [scheme.surface, scheme.surface];

    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
          ),
        ),
        child: Center(
          child: Transform.translate(
            offset: Offset(0, offsetProgressY),
            child: CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: isDark
                  ? AppColors.primaryDark.withValues(alpha: 0.3)
                  : AppColors.primaryLight.withValues(alpha: 0.3),
            ),
          ),
        ),
      ),
    );
  }
}
