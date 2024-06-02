import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

appToast({String? message, Color? bg}) {
  Fluttertoast.showToast(
    gravity: ToastGravity.TOP,
    backgroundColor: bg ?? Colors.black,
    textColor: Colors.white,
    msg: message.toString(),
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 2,
  );
}

showErorrToast(String message) {
  appToast(message: message, bg: Colors.red);
}

showSucessToast(String message) {
  appToast(message: message, bg: Colors.green);
}
