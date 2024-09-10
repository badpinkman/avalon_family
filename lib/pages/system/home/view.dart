import 'package:avalon_family/common/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    return Column(
      children: [
        // Header
        buildHeader(),
        SingleChildScrollView(
          child: <Widget>[
            // 构建Mini卡片
            buildMiniMachineCard(context),
            // 构建Nano3卡片
            buildNano3MachineCard(context),
          ].toColumn(),
        ).paddingOnly(left: 10, right: 10).expand(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: "home",
      builder: (_) {
        return SafeArea(
          child: _buildView(context),
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
        .padding(left: 20, right: 15, bottom: 10);
  }

  /// 构建机器卡片列表
  Widget buildNano3MachineCard(BuildContext context) {
    return GetBuilder<HomeController>(
      id: "nano3CardList",
      builder: (_) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 每行显示两个元素
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.3,
          ),
          itemCount: controller.nano3List.length,
          itemBuilder: (context, index) {
            Nano3MachineModel nano3 = controller.nano3List[index];
            return CupertinoContextMenu(
              actions: <Widget>[
                CupertinoContextMenuAction(
                  onPressed: () {
                    Logger.d('操作了删除按钮 : ${nano3.id}');
                    Navigator.pop(context);
                  },
                  isDestructiveAction: true,
                  trailingIcon: CupertinoIcons.delete,
                  child: Text('删除'.tr),
                ),
              ],
              child: buildNano3Item(nano3, context).onTap(() {
                Logger.d('普通点击 : ${nano3.id} ');
              }),
            );
          },
        );
      },
    );
  }

  /// 构建每一个Nano3卡片
  Widget buildNano3Item(Nano3MachineModel nano3, BuildContext context) {
    return <Widget>[
      <Widget>[
        Image.asset(
          'assets/images/devices2_300.png',
          width: 60,
          height: 60,
        ),
        const Spacer(),
        const Icon(Icons.chevron_right_sharp)
      ].toRow(),
      <Widget>[
        Text(nano3.model ?? '', style: AppTextStyles.titleMedium)
            .padding(left: 5),
      ].toRow(),
      <Widget>[
        Text(
          nano3.remark ?? '',
          style: AppTextStyles.labelMedium,
        ),
        const Spacer(),
        Text(nano3.online ?? false ? '' : '离线'.tr).padding(right: 5),
      ].toRow().padding(top: 10, left: 5),
    ]
        .toColumn()
        .padding(left: 15, right: 15, bottom: 15, top: 10)
        .width(
          0.45.sw,
        )
        .card(
          elevation: 1,
          color: Theme.of(context).colorScheme.onPrimary,
        )
        .center();
  }

  /// 构建每一个Mini卡片
  Widget buildMiniItem(MiniMachineModel mini, BuildContext context) {
    return <Widget>[
      <Widget>[
        Image.asset(
          'assets/images/devices2_300.png',
          width: 60,
          height: 60,
        ),
        const Spacer(),
        const Icon(Icons.chevron_right_sharp)
      ].toRow(),
      <Widget>[
        Text(mini.model ?? '', style: AppTextStyles.titleMedium)
            .padding(left: 5),
      ].toRow(),
      <Widget>[
        Text(
          mini.remark ?? '',
          style: AppTextStyles.labelMedium,
        ),
        const Spacer(),
        Text(mini.online ?? false ? '' : '离线'.tr).padding(right: 5),
      ].toRow().padding(top: 10, left: 5),
    ]
        .toColumn()
        .padding(left: 15, right: 15, bottom: 15, top: 10)
        .width(
          0.93.sw,
        )
        .card(
          elevation: 1,
          color: Theme.of(context).colorScheme.onPrimary,
        )
        .center();
  }

  /// 构建Mini卡片列表
  Widget buildMiniMachineCard(BuildContext context) {
    return GetBuilder<HomeController>(
      id: "miniCardList",
      builder: (_) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.miniList.length,
          itemBuilder: (context, index) {
            MiniMachineModel mini = controller.miniList[index];
            return CupertinoContextMenu(
              actions: <Widget>[
                CupertinoContextMenuAction(
                  onPressed: () {
                    Logger.d('操作了删除按钮 : ${mini.id}');
                    Navigator.pop(context);
                  },
                  isDestructiveAction: true,
                  trailingIcon: CupertinoIcons.delete,
                  child: Text('删除'.tr),
                ),
              ],
              child: buildMiniItem(mini, context).onTap(() {
                Logger.d('普通点击 : ${mini.id} ');
              }),
            );
          },
        ).paddingOnly(bottom: 5);
      },
    );
  }
}
