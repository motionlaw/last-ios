import 'dart:ui';

import 'package:flutter/material.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xFFffffff);
  static const Color loginGradientEnd = const Color(0xFFDB8C28);
  static const Color loginGradientButton = const Color(0XFF141035);
  static const Color motionTmBlue = const Color(0XFF141035);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}