import 'package:flutter/material.dart';
import 'package:snacker/snacker.dart';

class SnackerSettings {
  SnackerSettings({
    this.snackBarHorizontalPosition = SnackBarHorizontalPosition.right,
    this.snackBarVerticalPosition = SnackBarVerticalPosition.top,
    this.displayDuration = const Duration(seconds: 3),
    this.padding = const EdgeInsets.all(20),
  });

  SnackBarHorizontalPosition snackBarHorizontalPosition;
  SnackBarVerticalPosition snackBarVerticalPosition;
  Duration displayDuration;
  EdgeInsets padding;

  void setup({
    SnackBarHorizontalPosition? snackBarHorizontalPosition,
    SnackBarVerticalPosition? snackBarVerticalPosition,
    Duration? displayDuration,
    EdgeInsets? padding,
  }) {
    this.snackBarHorizontalPosition = snackBarHorizontalPosition ?? this.snackBarHorizontalPosition;
    this.snackBarVerticalPosition = snackBarVerticalPosition ?? this.snackBarVerticalPosition;
    this.displayDuration = displayDuration ?? this.displayDuration;
    this.padding = padding ?? this.padding;
  }
}
