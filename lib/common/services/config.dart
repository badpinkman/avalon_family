import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../index.dart';

/// 配置服务
class ConfigService extends GetxService {
  // 这是一个单例写法
  static ConfigService get to => Get.find();

  PackageInfo? _packageInfo;
  BaseDeviceInfo? _baseDeviceInfo;

  PackageInfo? _platform;
  String get version => _platform?.version ?? '-';

  //主题
  final ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  //语言
  Locale locale = PlatformDispatcher.instance.locale;

  // 初始化
  Future<ConfigService> init() async {
    await getPlatform();
    initLocale();
    return this;
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  // 获取包信息
  Future<PackageInfo> getPackageInfo() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }

  // 获设备信息
  Future<BaseDeviceInfo> getDeviceInfo() async {
    _baseDeviceInfo ??= await DeviceInfoPlugin().deviceInfo;
    return _baseDeviceInfo!;
  }

  // 初始语言
  void initLocale() {
    var langCode = Storage().getString(Constants.storageLanguageCode);
    if (langCode.isEmpty) return;
    var index = Translation.supportedLocales.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = Translation.supportedLocales[index];
  }

  // 更改语言
  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);

    /// 更改语言的时候, 将更改后的语言存储到KV中
    Storage().setString(Constants.storageLanguageCode, value.languageCode);
  }
}
