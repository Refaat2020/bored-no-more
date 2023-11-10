import 'package:another_flushbar/flushbar.dart';
import "package:flutter/material.dart";

import '../../core/config/app_route.dart';
import '../../core/constants/app_colors.dart';

notifySuccess(
  context, {
  IconData ?icon,
  String title = "Success!",
  String message = "The action was completed successfully.",
}) {
 return Flushbar(
    title: title,
    icon: Icon(
      icon ?? Icons.done,
      color: Colors.white,
      size: 26,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    barBlur: 2,
    backgroundColor: Color.fromRGBO(46, 159, 84, 0.9),
    message: message,
    duration: Duration(seconds: 3),
  )..show(context);
}


notifyError(
  BuildContext context, {
  String title = "Error!",
  String ?message = "Something went wrong!",
}) {
  Flushbar(
    icon: const Icon(Icons.error_outline, color: Colors.white, size: 26),
    title: title,
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    barBlur: 2,
    isDismissible: true,
    backgroundColor: AppColors.red1,
    message: message,
    duration: Duration(seconds: 3),
  ).show(context);
}

notifyInfo(
  {
 required Widget title,
    Widget? message,
    FlushbarPosition ?flushbarPosition
}) {
  Flushbar(
    barBlur: 2,
    titleText: title,
    isDismissible: true,
    borderRadius: BorderRadius.circular(8),
    messageText: message??const SizedBox(),
    flushbarPosition: flushbarPosition??FlushbarPosition.TOP,
    margin: const EdgeInsets.all(8),
    duration: const Duration(seconds: 3),
    backgroundColor: AppColors.green1,
    icon: const Icon(Icons.info_outline, color: Colors.white, size: 26),
  ).show(navigatorKey.currentContext!);
}
