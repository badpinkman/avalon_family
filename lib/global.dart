import 'package:avalon_family/common/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Global {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    setSystemUi();
    // 工具类
    await Storage().init();

    await Future.wait([
      Get.putAsync<ConfigService>(() async => await ConfigService().init()),
      Get.putAsync<DbService>(() async => await DbService().init()),
    ]).whenComplete(() {});
    Get.put<HttpService>(HttpService());
  }

  // 系统样式
  static void setSystemUi() {
    if (GetPlatform.isMobile) {
      // 屏幕方向 竖直上
      // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      // 透明状态栏
      // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //   statusBarColor: Colors.transparent, // transparent status bar
      // ));
    }

    if (GetPlatform.isAndroid) {
      // 去除顶部系统下拉和底部系统按键
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      // 去掉底部系统按键
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      //     overlays: [SystemUiOverlay.bottom]);

      // 自定义样式
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        // 顶部状态栏颜色
        statusBarColor: Colors.transparent,
        // 该属性仅用于 iOS 设备顶部状态栏亮度
        // statusBarBrightness: Brightness.light,
        // 顶部状态栏图标的亮度
        statusBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,

        // 底部状态栏与主内容分割线颜色
        systemNavigationBarDividerColor: Colors.transparent,
        // 底部状态栏颜色
        systemNavigationBarColor: Colors.transparent,
        // 底部状态栏图标样式
        systemNavigationBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
