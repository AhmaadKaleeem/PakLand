import 'package:flutter/material.dart';

// Defining Constant Color Theme FOr Pak land
class PakLandColor {
  static const Color primaryDark = Color(0xFF50207A);
  static const Color primaryLight = Color(0xFFD6B9FC);
  static const Color accentBlue = Color(0xFF838CE5);
  static const Color pureBlack = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF1E1E1E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white70 = Colors.white70;
  static const Color white54 = Colors.white54;
  static const Color white38 = Colors.white38;
  static const Color redAccent = Color(0xFFFF5252);
  static const Color green = Colors.green;
  static const Color transperant = Colors.transparent;

  // gradient

  static const LinearGradient maingradient = LinearGradient(
    begin: AlignmentGeometry.topCenter,
    end: AlignmentGeometry.bottomCenter,
    colors: [primaryDark, primaryLight],
    stops: [0.0, 1.0],
  );
}
