import 'package:dutch_hallae/utilities/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading {
  Loading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Center(
            child: CircularProgressIndicator(color: Palette.basicBlue),
          ),
        );
      },
    );
  }
}

class GetLoading {
  GetLoading() {
    Get.dialog(
      const Dialog(
        // insetPadding: EdgeInsets.zero,
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
