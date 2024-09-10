import 'package:avalon_family/common/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // title txt
      buildHeader(),
      // 构建机器卡片
      buildMachineCard(),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: "home",
      builder: (_) {
        return SafeArea(
          child: _buildView(),
        );
      },
    );
  }

  /// 构建Header
  Widget buildHeader() {
    return <Widget>[
      Text(
        '我的Avalon设备'.tr,
        style: AppTextStyles.titleLarge,
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.add_circle_outline_sharp,
          size: 25,
        ),
      )
    ]
        .toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
        .padding(left: 20, right: 10);
  }

  /// 构建机器卡片
  Widget buildMachineCard() {
    return SizedBox();
  }
}
