import 'package:avalon_family/common/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class TextPage extends GetView<TextController> {
  const TextPage({super.key});

  // 主视图
  Widget _buildView() {
    return Column(children: [
      ListTile(title: TextX.displayLarge('displayLarge')),
      ListTile(title: TextX.displayMedium('displayMedium')),
      ListTile(title: TextX.displaySmall('displaySmall')),
      ListTile(title: TextX.headlineLarge('headlineLarge')),
      ListTile(title: TextX.headlineMedium('headlineMedium')),
      ListTile(title: TextX.headlineSmall('headlineSmall')),
      ListTile(title: TextX.titleLarge('titleLarge')),
      ListTile(title: TextX.titleMedium('titleMedium')),
      ListTile(title: TextX.titleSmall('titleSmall')),
      ListTile(title: TextX.bodyLarge('bodyLarge')),
      ListTile(title: TextX.bodyMedium('bodyMedium')),
      ListTile(title: TextX.bodySmall('bodySmall')),
      ListTile(title: TextX.labelLarge('labelLarge')),
      ListTile(title: TextX.labelMedium('labelMedium')),
      ListTile(title: TextX.labelSmall('labelSmall')),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextController>(
      init: TextController(),
      id: "text",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("text")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
