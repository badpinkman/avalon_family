import 'package:avalon_family/common/index.dart';
import 'package:avalon_family/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _MainViewGetX();
  }
}

class _MainViewGetX extends GetView<MainController> {
  const _MainViewGetX({super.key});

  get _buildNavigation => NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          controller.pageController.jumpToPage(index);
        },
        backgroundColor: Theme.of(Get.context!).colorScheme.background,
        indicatorColor: Theme.of(Get.context!).colorScheme.primary,
        selectedIndex: controller.currentIndex.value,
        destinations: [
          _bottomItem('首页'.tr, Icons.home),
          _bottomItem('设置'.tr, Icons.settings),
        ],
      );

  /// 构建底部导航栏的按钮
  Widget _bottomItem(
    String title,
    IconData icon,
  ) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      selectedIcon: Icon(
        icon,
        color: Colors.white,
      ),
      label: title,
    );
  }

  // 主视图
  Widget _buildView() {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onBottomNavTap,
      physics: const NeverScrollableScrollPhysics(), // 如果删除这一行, 允许左右划动切换页面
      children: const [
        KeepAliveWrapper(child: HomePage()),
        KeepAliveWrapper(child: SettingsPage()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      id: "main",
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(title: const Text("main")),
          bottomNavigationBar: _buildNavigation,
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
