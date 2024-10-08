import 'package:flutter/material.dart';

import 'index.dart';

/// 主题
class AppTheme {
  /// 亮色
  static ThemeData light = ThemeData(
    colorScheme: lightColorScheme,
    useMaterial3: false,
    fontFamily: "AzoSans",
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(color: lightColorScheme.primary), // 修改为你想要的颜色
      ),
    ),
  );

  /// 暗色
  static ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
    useMaterial3: false,
    fontFamily: "AzoSans",
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: MaterialStateProperty.all(
        TextStyle(color: lightColorScheme.primary), // 修改为你想要的颜色
      ),
    ),
  );
}
