import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:yala/common/constants/app_dimens.dart';
import 'package:yala/common/enum/enums.dart';
import 'package:yala/presentation/widgets/custom_snackbar.dart';

enum SnackBarPosition {
  top,
  bottom,
}

OverlayEntry? _activeEntry;

void showMessage({
  required BuildContext context,
  required String message,
  required SnackbarEnum type,
  SnackBarPosition position = SnackBarPosition.top,
}) {
  // descarta el anterior si sigue visible
  if (_activeEntry != null && _activeEntry!.mounted) {
    _activeEntry!.remove();
    _activeEntry = null;
  }

  final overlayState = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => SnackBarAnimation(
      onDismissed: () {
        entry.remove();
        _activeEntry = null;
      },
      animationDuration: const Duration(milliseconds: 350),
      reverseAnimationDuration: const Duration(milliseconds: 250),
      displayDuration: const Duration(milliseconds: 2500),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
      snackBarPosition: position,
      child: CustomSnackbar(
        text: message,
        snackbarEnum: type,
        onDismiss: () {
          entry.remove();
          _activeEntry = null;
        },
      ),
    ),
  );

  _activeEntry = entry;
  overlayState.insert(entry);
}

class SnackBarAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final Duration animationDuration;
  final Duration reverseAnimationDuration;
  final Duration displayDuration;
  final EdgeInsets padding;
  final Curve curve;
  final Curve reverseCurve;
  final SnackBarPosition snackBarPosition;

  const SnackBarAnimation({
    super.key,
    required this.child,
    required this.onDismissed,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    required this.displayDuration,
    required this.padding,
    required this.curve,
    required this.reverseCurve,
    required this.snackBarPosition,
  });

  @override
  State<SnackBarAnimation> createState() => _SnackBarAnimationState();
}

class _SnackBarAnimationState extends State<SnackBarAnimation> with SingleTickerProviderStateMixin {
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _animationController;
  late final Tween<Offset> _offsetTween;
  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.reverseAnimationDuration,
    );
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _timer = Timer(widget.displayDuration, () {
            if (mounted) {
              _animationController.reverse();
            }
          });
        }
        if (status == AnimationStatus.dismissed) {
          _timer?.cancel();
          widget.onDismissed.call();
        }
      },
    );

    switch (widget.snackBarPosition) {
      case SnackBarPosition.top:
        _offsetTween = Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        );
        break;
      case SnackBarPosition.bottom:
        _offsetTween = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        );
        break;
    }

    _offsetAnimation = _offsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    );
    if (mounted) {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.snackBarPosition == SnackBarPosition.top ? widget.padding.top : null,
      bottom: widget.snackBarPosition == SnackBarPosition.bottom ? widget.padding.bottom : null,
      left: widget.padding.left,
      right: widget.padding.right,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SafeArea(
          child: widget.child,
        ),
      ),
    );
  }
}
