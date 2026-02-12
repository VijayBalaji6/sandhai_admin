import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class ToastUtils {
  static const Duration _defaultDuration = Duration(seconds: 4);
  static const Alignment _alignment = Alignment.topLeft;

  static void showSuccessToast(String msg) => _showToast(
        msg: msg,
        type: ToastificationType.success,
        backgroundColor: const Color(0xFFFFFFFF),
        primaryColor: const Color(0xFF2E7D32), // green
      );

  static void showErrorToast(Object msg) => _showToast(
        msg: msg.toString(),
        type: ToastificationType.error,
        backgroundColor: const Color(0xFFFFFFFF),
        primaryColor: const Color(0xFFC62828), // red
      );

  static void showInfoToast(String msg) => _showToast(
        msg: msg,
        type: ToastificationType.info,
        backgroundColor: const Color(0xFFFFFFFF),
        primaryColor: const Color(0xFF1565C0), // blue
      );

  static void _showToast({
    required String msg,
    required ToastificationType type,
    required Color backgroundColor,
    required Color primaryColor,
  }) {
    toastification.dismissAll();

    toastification.show(
      title: Text(
        msg,
        maxLines: 10,
        overflow: TextOverflow.visible,
        style: const TextStyle(fontSize: 14),
      ),
      type: type,
      alignment: _alignment,
      autoCloseDuration: _defaultDuration,
      style: ToastificationStyle.minimal,
      showProgressBar: false,
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(20),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.always),
      backgroundColor: backgroundColor,
      primaryColor: primaryColor,
    );
  }
}
