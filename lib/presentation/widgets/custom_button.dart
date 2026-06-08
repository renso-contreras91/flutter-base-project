// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:yala/common/constants/app_dimens.dart';
import 'package:yala/common/constants/app_text_size.dart';

enum ButtonType {
  Primary,
  Secondary,
  Tertiary,
}

class CustomButton extends StatelessWidget {
  final String textValue;
  final ButtonType type;
  final bool isEnabled;
  final bool isFillMaxWidth;
  final double height;
  final double roundedCornerSize;
  final ButtonStyle? buttonStyle;
  final VoidCallback onClickBtn;

  const CustomButton({
    super.key,
    required this.textValue,
    required this.onClickBtn,
    this.type = ButtonType.Primary,
    this.isEnabled = true,
    this.isFillMaxWidth = true,
    this.height = AppComponent.buttonHeight,
    this.roundedCornerSize = AppShape.field,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(roundedCornerSize),
    );

    final sizeModifier = SizedBox(
      width: isFillMaxWidth ? double.infinity : null,
      height: height,
      child: _buildButton(context, shape),
    );

    return sizeModifier;
  }

  Widget _buildButton(
    BuildContext context,
    RoundedRectangleBorder shape,
  ) {
    final label = Text(
      textValue,
      style: const TextStyle(
        fontSize: AppTextSize.bodyMedium,
        fontWeight: FontWeight.w400,
      ),
    );

    return switch (type) {
      ButtonType.Primary => FilledButton(
        onPressed: isEnabled ? onClickBtn : null,
        style:
            buttonStyle ??
            FilledButton.styleFrom(
              foregroundColor: Colors.white,
              shape: shape,
            ),
        child: label,
      ),
      ButtonType.Secondary => OutlinedButton(
        onPressed: isEnabled ? onClickBtn : null,
        style:
            buttonStyle ??
            OutlinedButton.styleFrom(
              shape: shape,
            ),
        child: label,
      ),
      ButtonType.Tertiary => TextButton(
        onPressed: isEnabled ? onClickBtn : null,
        style:
            buttonStyle ??
            TextButton.styleFrom(
              shape: shape,
            ),
        child: label,
      ),
    };
  }
}
