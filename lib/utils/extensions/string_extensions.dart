import 'package:flutter/material.dart';

extension StringExtensions on String {
  String get toSvg => "assets/icons/$this.svg";

  String get toPng => "assets/images/$this.png";

  String get toJpg => "assets/images/$this.jpg";

  String get toGif => "assets/images/$this.gif";

  Color toColor() {
    String hexString = toUpperCase().replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
