import 'package:flutter/material.dart';

import 'app_enums.dart';

class AppColors {
  static const Color primaryColor = Color(0xff082659);
  static const Color secondaryColor = Color(0xff51eec2);
  static const Color textColor = Colors.white;
  static const Color icoColor = Colors.white;

  //toast color
  static Color choseToastColor(ToastStatus status) {
    Color color;
    switch (status) {
      case ToastStatus.success:
        color = Colors.green;
        break;
      case ToastStatus.error:
        color = Colors.red;
        break;
    }
    return color;
  }

  //snackBar colors
  static Color choseSnackBarColor(SnackStatus snackStatus) {
    Color color;
    switch (snackStatus) {
      case SnackStatus.success:
        color = Colors.green;
        break;
      case SnackStatus.error:
        color = Colors.red;
        break;
    }
    return color;
  }
}
