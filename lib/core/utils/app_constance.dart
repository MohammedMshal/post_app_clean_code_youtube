import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';
import 'app_enums.dart';

class AppConstance {
  static Widget loadingPage({
    Color color = AppColors.secondaryColor,
  }) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }

  static void showErrorDialog(
      {required BuildContext context, required String msg}) {
    showDialog(
      context: context,
      builder: (context) =>
          CupertinoAlertDialog(
            title: Text(msg),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('oK'))
            ],
          ),
    );
  }

  static Future<bool?> showToast({
    required String msg,
    required ToastStatus status,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: AppColors.choseToastColor(status),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showSnackBar({
    required String msg,
    required SnackStatus snackStatus,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg),
          backgroundColor: AppColors.choseSnackBarColor(snackStatus),
        )
    );
  }

  static void navigatorTo({
    required BuildContext context,
    required String route,
  }) {
    Navigator.pushNamed(context, route);
  }

  static void navigatorRemovedTo({
    required BuildContext context,
    required String route,
  }) {
    Navigator.pushReplacementNamed(context, route);
  }


  static void navigatorToAno(
      {required BuildContext context, required Widget screen}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static void navigatorRemoveToAno(
      {required BuildContext context, required Widget screen}) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => screen),(route) => false,);
  }

  static void navigatorPop(
      {required BuildContext context}) {
    Navigator.of(context).pop();
  }


}
