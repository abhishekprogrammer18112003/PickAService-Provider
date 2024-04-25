// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';

class ScreenUtil {
  static const Size defaultSize = Size(360, 690);
  static late ScreenUtil _instance;

  late Size uiSize;

  late bool allowFontScaling;

  late Orientation _orientation;

  late double _pixelRatio;
  late double _textScaleFactor;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;

  ScreenUtil._();

  factory ScreenUtil() {
    return _instance;
  }

  static void init(
    BoxConstraints constraints, {
    Orientation orientation = Orientation.portrait,
    Size designSize = defaultSize,
    bool allowFontScaling = false,
  }) {
    _instance = ScreenUtil._()
      ..uiSize = designSize
      ..allowFontScaling = allowFontScaling
      .._orientation = orientation
      .._screenWidth = constraints.maxWidth
      .._screenHeight = constraints.maxHeight;

    var window = WidgetsBinding.instance.window;
    _instance._pixelRatio = window.devicePixelRatio;
    _instance._statusBarHeight = window.padding.top;
    _instance._bottomBarHeight = window.padding.bottom;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  Orientation get orientation => _orientation;

  double get textScaleFactor => _textScaleFactor;
  double get pixelRatio => _pixelRatio;
  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get statusBarHeight => _statusBarHeight / _pixelRatio;
  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;
  double get scaleWidth => _screenWidth / uiSize.width;
  double get scaleHeight => _screenHeight / uiSize.height;
  double get scaleText => min(scaleWidth, scaleHeight);

  double setWidth(num width) => width * scaleWidth;
  double setHeight(num height) => height * scaleHeight;
  double radius(num r) => r * scaleText;
  double setSp(num fontSize, {bool? allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (allowFontScaling
              ? (fontSize * scaleText) * _textScaleFactor
              : (fontSize * scaleText))
          : (allowFontScalingSelf
              ? (fontSize * scaleText) * _textScaleFactor
              : (fontSize * scaleText));
}

class ScreenUtilInit extends StatelessWidget {
  const ScreenUtilInit({
    required this.builder,
    this.designSize = ScreenUtil.defaultSize,
    this.allowFontScaling = false,
    Key? key,
  }) : super(key: key);

  final Widget Function() builder;
  final Size designSize;
  final bool allowFontScaling;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return OrientationBuilder(
        builder: (_, Orientation orientation) {
          if (constraints.maxWidth != 0) {
            ScreenUtil.init(
              constraints,
              orientation: orientation,
              designSize: designSize,
              allowFontScaling: allowFontScaling,
            );
            return builder();
          }
          return Container();
        },
      );
    });
  }
}

extension SizeExtension on num {
  double get w => ScreenUtil().setWidth(this);
  double get h => ScreenUtil().setHeight(this);
  double get r => ScreenUtil().radius(this);
  double get sp => ScreenUtil().setSp(this);
  double get ssp => ScreenUtil().setSp(this, allowFontScalingSelf: true);
  double get nsp => ScreenUtil().setSp(this, allowFontScalingSelf: false);
  double get sw => ScreenUtil().screenWidth * this;
  double get sh => ScreenUtil().screenHeight * this;
}
