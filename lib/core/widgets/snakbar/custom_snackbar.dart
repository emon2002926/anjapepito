import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

  class CustomSnackBar {
    CustomSnackBar._();

    static void _show(
        String message, {
          required Color color,
          IconData? icon,
          Duration duration = const Duration(seconds: 3),
          SnackBarAction? action,
        }) {
      final ctx = Get.context;
      if (ctx == null) {
        print('Snackbar: $message');
        return;
      }

      final screenHeight = MediaQuery.of(ctx).size.height;
      final topPadding = MediaQuery.of(ctx).padding.top;

      final snack = SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
            ],
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          top: topPadding + 8,
          // Push snackbar to top by setting a large bottom margin
          bottom: screenHeight - topPadding - 80,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: action,
      );

      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      ScaffoldMessenger.of(ctx).showSnackBar(snack);
    }

    static void success(String message, {Duration? duration, SnackBarAction? action}) =>
        _show(message, color: Colors.green.shade600, icon: Icons.check_circle, duration: duration ?? const Duration(seconds: 3), action: action);

    static void error(String message, {Duration? duration, SnackBarAction? action}) =>
        _show(message, color: Colors.red.shade700, icon: Icons.error, duration: duration ?? const Duration(seconds: 4), action: action);

    static void warning(String message, {Duration? duration, SnackBarAction? action}) =>
        _show(message, color: Colors.amber.shade800, icon: Icons.warning, duration: duration ?? const Duration(seconds: 3), action: action);

    static void info(String message, {Duration? duration, SnackBarAction? action}) =>
        _show(message, color: Colors.blue.shade700, icon: Icons.info_outline, duration: duration ?? const Duration(seconds: 3), action: action);

    static void show(String message, {Duration? duration, SnackBarAction? action}) =>
        info(message, duration: duration, action: action);
  }