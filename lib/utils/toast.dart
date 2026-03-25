import 'package:flutter/material.dart' show Color, Colors;
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;

void showToast({required ToastType type, required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: .LENGTH_LONG,
    gravity: .BOTTOM,
    backgroundColor: type.color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastType {
  success(Color(0xFF34C759)),
  error(Color(0xFFFF3B30)),
  info(Color(0xFF0A84FF)),
  warning(Color(0xFFFF9F0A));

  final Color color;
  const ToastType(this.color);
}
