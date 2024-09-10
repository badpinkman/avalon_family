import 'package:avalon_family/common/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  MainController();

  final currentIndex = 0.obs;
  final PageController pageController = PageController(
    initialPage: 0,
  );

  /// 页面切换监听
  void onBottomNavTap(int index) {
    /// 可以使用此方式来替换 currentIndex.value = XXX;
    Logger.d('切换页面 = $index');
    currentIndex(index);
    pageController.jumpToPage(index);
    update(["main"]);
  }

  _initData() {
    update(["main"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }
}
