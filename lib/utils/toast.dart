import 'package:flutter/material.dart' show Colors;
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;

void showToast({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: .LENGTH_SHORT,
    gravity: .BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
