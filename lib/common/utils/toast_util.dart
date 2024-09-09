import 'package:avalon_family/common/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Toast工具
class Toast {
  static void show(
    String text, {
    Image? preIcon,
    Duration? length,
    BrnToastGravity? gravity,
  }) {
    BrnToast.show(
      text,
      Get.context!,
      preIcon: preIcon,
      duration: length,
      gravity: gravity ?? BrnToastGravity.bottom,
      verticalOffset: 80,
    );
  }

  static void success(
    String text, {
    Duration? length,
    BrnToastGravity? gravity,
  }) {
    Toast.show(
      text,
      preIcon: Image.asset(
        'assets/icons/ic_success.png',
        // package: pluginPackageName,
        width: 20,
        height: 20,
      ),
      length: length,
      gravity: gravity,
    );
  }

  static void error(
    String text, {
    Duration? length,
    BrnToastGravity? gravity,
  }) {
    Toast.show(
      text,
      preIcon: Image.asset(
        'assets/icons/ic_error.png',
        // package: pluginPackageName,
        width: 20,
        height: 20,
      ),
      length: length,
      gravity: gravity,
    );
  }

  static void info(
    String text, {
    Duration? length,
    BrnToastGravity? gravity,
  }) {
    Toast.show(
      text,
      preIcon: Image.asset(
        'assets/icons/ic_info.png',
        // package: pluginPackageName,
        width: 20,
        height: 20,
      ),
      length: length,
      gravity: gravity,
    );
  }

  static void warning(
    String text, {
    Duration? length,
    BrnToastGravity? gravity,
  }) {
    Toast.show(
      text,
      preIcon: Image.asset(
        'assets/icons/ic_warning.png',
        // package: pluginPackageName,
        width: 20,
        height: 20,
      ),
      length: length,
      gravity: gravity,
    );
  }
}
