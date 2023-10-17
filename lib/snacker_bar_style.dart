import 'package:flutter/material.dart';

import 'constants.dart';

class SnackerBarStyle {
  const SnackerBarStyle.info({
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    this.maxLines = 2,
    this.backgroundColor = kDefaultInfoBGColor,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.borderWidth = 0,
    this.borderColor = kDefaultInfoBorderColor,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  });

  const SnackerBarStyle.success({
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    this.maxLines = 2,
    this.backgroundColor = kDefaultSuccessBGColor,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.borderWidth = 0,
    this.borderColor = kDefaultSuccessBorderColor,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  });

  const SnackerBarStyle.error({
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    this.maxLines = 2,
    this.backgroundColor = kDefaultErrorBGColor,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.borderWidth = 0,
    this.borderColor = kDefaultErrorBorderColor,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  });


  final Color? backgroundColor;
  final TextStyle? textStyle;
  final int? maxLines;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final EdgeInsetsGeometry? messagePadding;
  final double? textScaleFactor;
  final TextAlign? textAlign;
}



const kDefaultBoxShadow = [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 8),
    spreadRadius: 1,
    blurRadius: 30,
  ),
];


