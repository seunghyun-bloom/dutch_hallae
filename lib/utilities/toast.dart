import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.grey.shade200,
    textColor: Colors.black,
  );
}
