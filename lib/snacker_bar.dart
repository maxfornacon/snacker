import 'package:flutter/material.dart';
import 'package:snacker/snacker.dart';

import 'constants.dart';

class SnackerBar extends StatefulWidget {
  const SnackerBar({
    Key? key,
    required this.message,
    this.style = const SnackerBarStyle.info(),
  }) : super(key: key);

  final String message;
  final SnackerBarStyle style;

  @override
  State<SnackerBar> createState() => _SnackerBarState();
}

class _SnackerBarState extends State<SnackerBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: widget.style.backgroundColor,
        borderRadius: widget.style.borderRadius,
        border: Border.all(
          color: widget.style.borderColor ?? const Color(0xFF000000),
          width: widget.style.borderWidth ?? 1.0,
        ),
        boxShadow: widget.style.boxShadow,
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: widget.style.messagePadding ?? EdgeInsets.zero,
              child: Text(
                widget.message,
                style: theme.textTheme.bodyMedium?.merge(widget.style.textStyle),
                textAlign: widget.style.textAlign,
                overflow: TextOverflow.ellipsis,
                maxLines: widget.style.maxLines,
                textScaleFactor: widget.style.textScaleFactor,
              ),
            ),
          ),
        ],
      ),
    );

    return SizedBox(
      height: 60,
      width: double.infinity,
      child: snackerSettings.snackBarHorizontalPosition != SnackBarHorizontalPosition.middle ? Row(
        mainAxisAlignment: snackerSettings.snackBarHorizontalPosition == SnackBarHorizontalPosition.left
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          child
        ],
      ) : child,
    );
  }
}