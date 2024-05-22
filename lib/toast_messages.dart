import 'package:flutter/material.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toasty_box.dart';

class WarningHelper {
  static showErrorToast(String message, context) {
    return ToastService.showErrorToast(context,
        isClosable: true,
        length: ToastLength.short,
        shadowColor: Colors.black.withOpacity(0.2),
        backgroundColor: Colors.red.shade400,
        positionCurve: Curves.easeInOut,
        slideCurve: Curves.easeOut,
        message: message);
  }

  static showSuccesToast(String message, context) {
    return ToastService.showSuccessToast(context,
        isClosable: true,
        length: ToastLength.short,
        shadowColor: Colors.black.withOpacity(0.2),
        backgroundColor: Colors.green.shade500,
        positionCurve: Curves.easeInOut,
        slideCurve: Curves.easeOut,
        message: message);
  }
}
