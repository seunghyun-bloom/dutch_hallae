import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.blueGrey.shade100,
    textColor: Colors.black,
  );
}
