import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double heightByDesign(double height) {
    return (MediaQuery.of(this).size.height * height) / 2400;
  }

  double widthByDesign(double width) {
    return (MediaQuery.of(this).size.width * width) / 1080;
  }
}
