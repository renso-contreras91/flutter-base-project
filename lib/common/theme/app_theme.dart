import 'package:flutter/material.dart';
import 'package:yala/common/constants/app_colors.dart';

abstract final class AppTheme {
   static ThemeData get light => ThemeData(
    colorScheme: lightColorScheme,
    fontFamily: 'Nunito',
    useMaterial3: true,
  );

  static ThemeData get dark => ThemeData(
    colorScheme: darkColorScheme,
    fontFamily: 'Nunito',
    useMaterial3: true,
  );
}
