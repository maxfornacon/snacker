library snacker;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snacker/snacker_settings.dart';
import 'package:snacker/tap_bounce_container.dart';

export 'snacker_bar_style.dart';
export 'snacker_bar.dart';
export 'snacker_settings.dart';

OverlayEntry? _previousEntry;
SnackerSettings snackerSettings = SnackerSettings();


void deliverSnack(
  BuildContext context,
  Widget child,
  {
    Duration animationDuration = const Duration(milliseconds: 1200),
    Duration reverseAnimationDuration = const Duration(milliseconds: 550),
    Duration? displayDuration,
    VoidCallback? onTap,
    bool persistent = false,
    ControllerCallback? onAnimationControllerInit,
    EdgeInsets? padding,
    Curve curve = Curves.elasticOut,
    Curve reverseCurve = Curves.linearToEaseOut,
    DismissType dismissType = DismissType.tap,
    List<DismissDirection> dismissDirection = const [DismissDirection.up],
  }
) {
  late OverlayEntry _overlayEntry;
  _overlayEntry = OverlayEntry(
    builder: (_) {
      return _SnackerBar(
        onDismissed: () {
          _overlayEntry.remove();
          _previousEntry = null;
        },
        animationDuration: animationDuration,
        reverseAnimationDuration: reverseAnimationDuration,
        displayDuration: displayDuration ?? snackerSettings.displayDuration ,
        onTap: onTap,
        persistent: persistent,
        onAnimationControllerInit: onAnimationControllerInit,
        padding: padding ?? snackerSettings.padding,
        curve: curve,
        reverseCurve: reverseCurve,
        dismissType: dismissType,
        dismissDirections: dismissDirection,
        child: child,
      );
    },
  );

  if (_previousEntry != null && _previousEntry!.mounted) {
    _previousEntry?.remove();
  }

  Overlay.of(context).insert(_overlayEntry);
  _previousEntry = _overlayEntry;
}

class _SnackerBar extends StatefulWidget {
  const _SnackerBar({
    Key? key,
    required this.child,
    required this.onDismissed,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    required this.displayDuration,
    required this.padding,
    required this.curve,
    required this.reverseCurve,
    required this.dismissDirections,
    this.onTap,
    this.persistent = false,
    this.onAnimationControllerInit,
    this.dismissType = DismissType.tap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onDismissed;
  final Duration animationDuration;
  final Duration reverseAnimationDuration;
  final Duration displayDuration;
  final VoidCallback? onTap;
  final ControllerCallback? onAnimationControllerInit;
  final bool persistent;
  final EdgeInsets padding;
  final Curve curve;
  final Curve reverseCurve;
  final DismissType dismissType;
  final List<DismissDirection> dismissDirections;

  @override
  _SnackerBarState createState() => _SnackerBarState();
}

class _SnackerBarState extends State<_SnackerBar> with SingleTickerProviderStateMixin {
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _animationController;

  Timer? _timer;

  late final Tween<Offset> _offsetTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.reverseAnimationDuration,
    );
    _animationController.addStatusListener(
          (status) {
        if (status == AnimationStatus.completed && !widget.persistent) {
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

    widget.onAnimationControllerInit?.call();

    switch(snackerSettings.snackBarVerticalPosition) {
      case SnackBarVerticalPosition.top:
        _offsetTween = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
        break;
      case SnackBarVerticalPosition.bottom:
        _offsetTween = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);
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
      top: snackerSettings.snackBarVerticalPosition == SnackBarVerticalPosition.top ? widget.padding.top : null,
      bottom: snackerSettings.snackBarVerticalPosition == SnackBarVerticalPosition.bottom ? widget.padding.bottom : null,
      left: widget.padding.left,
      right: widget.padding.right,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SafeArea(
          child: _buildDismissibleChild(),
        ),
      ),
    );
  }

  /// Build different type of [Widget] depending on [DismissType] value
  Widget _buildDismissibleChild() {
    switch (widget.dismissType) {
      case DismissType.tap:
        return TapBounceContainer(
          onTap: () {
            widget.onTap?.call();
            if (!widget.persistent && mounted) {
              _animationController.reverse();
            }
          },
          child: widget.child,
        );
      case DismissType.swipeHorizontal:
        var childWidget = widget.child;
        for (final direction in widget.dismissDirections) {
          childWidget = Dismissible(
            direction: direction,
            key: UniqueKey(),
            dismissThresholds: const {DismissDirection.up: 0.2},
            confirmDismiss: (direction) async {
              if (!widget.persistent && mounted) {
                if (direction == DismissDirection.down) {
                  await _animationController.reverse();
                } else {
                  _animationController.reset();
                }
              }
              return false;
            },
            child: childWidget,
          );
        }
        return childWidget;
      case DismissType.none:
        return widget.child;
      case DismissType.swipeVertical:
        // TODO: Handle this case.
        return widget.child;
    }
  }
}

enum DismissType {
  tap,
  swipeVertical,
  swipeHorizontal,
  none
}

enum SnackBarVerticalPosition {
  top,
  bottom,
}
enum SnackBarHorizontalPosition {
  left,
  right,
  middle,
}
