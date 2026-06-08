// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:yala/common/constants/app_constants.dart';
import 'package:yala/common/constants/app_dimens.dart';
import 'package:yala/common/constants/app_text_size.dart';
import 'package:yala/common/extension/string_extensions.dart';

enum InputTypeEnum {
  ALL,
  PASSWORD,
  DROPDOWN,
  CODE,
}

class CustomTextField extends StatefulWidget {
  final String textValue;
  final String textTitle;
  final String textPlaceHolder;
  final String messageError;
  final bool isError;
  final bool isOpened;
  final bool isEnabled;
  final bool singleLine;
  final bool isReadOnly;
  final bool obscureText;
  final bool disableError;
  final bool disableClear;
  final int? maxLength;
  final int maxLines;
  final int maxLinesError;
  final double radius;
  final bool filled;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final TextAlign textAlign;
  final IconData? prefixIcon;
  final InputTypeEnum inputTypeEnum;
  final TextEditingController? textEditingController;
  final void Function(String text)? onValueChange;
  final void Function(bool hasFocus)? onFocusChanged;
  final void Function()? onClickSuffixIcon;

  const CustomTextField({
    super.key,
    this.textValue = AppConstants.EMPTY_STRING,
    this.textTitle = AppConstants.EMPTY_STRING,
    this.textPlaceHolder = AppConstants.EMPTY_STRING,
    this.messageError = AppConstants.EMPTY_STRING,
    this.isError = false,
    this.isOpened = false,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.singleLine = true,
    this.obscureText = false,
    this.disableError = false,
    this.disableClear = false,
    this.maxLength,
    this.maxLines = AppConstants.NUMBER_ONE,
    this.maxLinesError = AppConstants.NUMBER_ONE,
    this.radius = AppShape.field,
    this.filled = true,
    this.inputTypeEnum = InputTypeEnum.ALL,
    this.contentPaddingHorizontal = AppSpacing.lg,
    this.contentPaddingVertical = AppSpacing.lg,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.textEditingController,
    this.onValueChange,
    this.onFocusChanged,
    this.onClickSuffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  bool _hasFocus = false;
  bool _isTextHide = false;

  // Usamos un controller interno si el padre no pasa uno,
  // para poder escuchar cambios de texto y redibujar el suffixIcon.
  late final TextEditingController _internalController;
  TextEditingController get _effectiveController => widget.textEditingController ?? _internalController;

  @override
  void initState() {
    super.initState();

    _isTextHide = widget.inputTypeEnum == InputTypeEnum.PASSWORD ? widget.obscureText : false;

    // Solo lo creas si el padre no pasó uno
    _internalController = TextEditingController(text: widget.textValue);

    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);

    // Escuchamos el controller para redibujar cuando el texto cambia
    // (necesario para mostrar/ocultar el ícono clear condicionalmente).
    _effectiveController.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si el padre cambia el controller, re-enganchamos el listener.
    if (oldWidget.textEditingController != widget.textEditingController) {
      oldWidget.textEditingController?.removeListener(_onTextChanged);
      widget.textEditingController?.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _effectiveController.removeListener(_onTextChanged);
    _internalController.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    final hasFocus = _focusNode.hasFocus;
    setState(() => _hasFocus = hasFocus);
    widget.onFocusChanged?.call(hasFocus);
  }

  void _onTextChanged() {
    // Forzamos rebuild para que suffixIcon clear se muestre/oculte.
    setState(() {});
  }

  // ─── Color helpers ────────────────────────────────────────────────────────

  /// Color del título: error > focused > normal.
  Color _titleColor(ColorScheme colorScheme) {
    if (widget.isError && !widget.disableError) return colorScheme.error;
    if (_hasFocus || widget.isOpened) return colorScheme.primary;
    return colorScheme.onSurface;
  }

  /// Color del borde: error > focused > normal.
  Color _borderColor(ColorScheme colorScheme) {
    if (widget.isError && !widget.disableError) return colorScheme.error;
    if (_hasFocus || widget.isOpened) return colorScheme.primary;
    return colorScheme.outline;
  }

  // ─── Suffix icon ──────────────────────────────────────────────────────────

  /// Equivalente al bloque `trailing` del Kotlin:
  /// cada caso del enum decide qué ícono (o nada) mostrar.
  IconData? get _suffixIconData {
    final hasText = _effectiveController.text.isNotEmpty;

    return switch (widget.inputTypeEnum) {
      // Clear solo aparece si hay texto, el campo está habilitado
      // y no se deshabilitó explícitamente.
      InputTypeEnum.ALL => (hasText && widget.isEnabled && !widget.disableClear) ? Icons.clear : null,

      InputTypeEnum.PASSWORD => _isTextHide ? Icons.visibility_off : Icons.visibility_outlined,

      InputTypeEnum.DROPDOWN => widget.isOpened ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,

      InputTypeEnum.CODE => null,
    };
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        _buildTextField(context),
        _buildMessageError(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (widget.textTitle.isNullOrBlank) {
      return const SizedBox.shrink();
    }
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
      child: Text(
        widget.textTitle.orEmpty(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppTextSize.bodyMedium,
          color: _titleColor(colorScheme),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = _borderColor(colorScheme);
    final suffixIconData = _suffixIconData;

    final iconConstraints = BoxConstraints.tight(
      const Size(
        AppIcon.md,
        AppIcon.md,
      ),
    );

    // ── Borders ──────────────────────────────────────────────────────────────
    // Seguimos el mismo patrón del Kotlin:
    //   enabled   → borde con color según estado (error/normal)
    //   focused   → borde primary o error con width 2
    //   error     → borde error sin foco
    //   focusedError → borde error con width 2

    final normalBorder = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(widget.radius),
    );

    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: (widget.isError && !widget.disableError) ? colorScheme.error : colorScheme.primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(widget.radius),
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.error),
      borderRadius: BorderRadius.circular(widget.radius),
    );

    final focusedErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.error, width: 2),
      borderRadius: BorderRadius.circular(widget.radius),
    );

    // ── Suffix icon widget ────────────────────────────────────────────────────
    final suffixWidget = suffixIconData != null
        ? GestureDetector(
            onTap: _actionSuffixIcon,
            child: Icon(
              suffixIconData,
              color: (widget.isError && !widget.disableError) ? colorScheme.error : null,
            ),
          )
        : null;

    // ── Decoration ────────────────────────────────────────────────────────────
    final decoration = InputDecoration(
      filled: widget.filled,
      fillColor: colorScheme.surfaceContainerHighest,
      enabledBorder: normalBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: focusedErrorBorder,
      prefixIconConstraints: iconConstraints,
      suffixIconConstraints: iconConstraints,
      isDense: true,
      hintText: widget.textPlaceHolder,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppTextSize.bodyMedium,
        color: colorScheme.onSurface.withValues(alpha: 0.4),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: widget.contentPaddingHorizontal,
        vertical: widget.contentPaddingVertical,
      ),
      prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
      suffixIcon: suffixWidget,
    );

    final textField = TextField(
      focusNode: _focusNode,
      controller: _effectiveController,
      obscureText: _isTextHide,
      maxLength: widget.maxLength,
      maxLines: widget.singleLine ? AppConstants.NUMBER_ONE : widget.maxLines,
      textAlign: widget.textAlign,
      enabled: widget.isEnabled,
      readOnly: widget.isReadOnly,
      keyboardType: _keyboardType,
      decoration: decoration,
      onChanged: (value) => widget.onValueChange?.call(value),
    );

    return widget.singleLine
        ?  SizedBox(
        height: AppComponent.fieldHeight,
        child: textField,
      )
        : ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppComponent.fieldHeight,
            ),
            child: textField,
          );
  }

  Widget _buildMessageError(BuildContext context) {
    if (widget.disableError || widget.messageError.isNullOrBlank || !widget.isError) {
      return const SizedBox.shrink();
    }
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxs),
      child: Text(
        widget.messageError.orEmpty(),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppTextSize.bodyMedium,
          color: colorScheme.error,
        ),
      ),
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  TextInputType get _keyboardType => switch (widget.inputTypeEnum) {
    InputTypeEnum.PASSWORD => TextInputType.visiblePassword,
    InputTypeEnum.CODE => TextInputType.number,
    _ => TextInputType.text,
  };

  void _actionSuffixIcon() {
    switch (widget.inputTypeEnum) {
      case InputTypeEnum.ALL:
        _effectiveController.clear();
        widget.onValueChange?.call(AppConstants.EMPTY_STRING);
        widget.onClickSuffixIcon?.call();

      case InputTypeEnum.PASSWORD:
        setState(() => _isTextHide = !_isTextHide);

      case InputTypeEnum.DROPDOWN:
        widget.onClickSuffixIcon?.call();

      case InputTypeEnum.CODE:
        break;
    }
  }
}
