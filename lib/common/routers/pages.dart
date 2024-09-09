import 'package:avalon_family/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class RoutePages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];
  // 列表
  static List<GetPage> list = [
    GetPage(
      name: RouteNames.myLanguage,
      page: () => const LanguagePage(),
    ),
    GetPage(
      name: RouteNames.myMyIndex,
      page: () => const MyIndexPage(),
    ),
    GetPage(
      name: RouteNames.myTheme,
      page: () => const ThemePage(),
    ),
    GetPage(
      name: RouteNames.stylesBottomSheet,
      page: () => const BottomSheetPage(),
    ),
    GetPage(
      name: RouteNames.stylesButtons,
      page: () => const ButtonsPage(),
    ),
    GetPage(
      name: RouteNames.stylesCarousel,
      page: () => const CarouselPage(),
    ),
    GetPage(
      name: RouteNames.stylesComponents,
      page: () => const ComponentsPage(),
    ),
    GetPage(
      name: RouteNames.stylesGroupList,
      page: () => const GroupListPage(),
    ),
    GetPage(
      name: RouteNames.stylesIcon,
      page: () => const IconPage(),
    ),
    GetPage(
      name: RouteNames.stylesImage,
      page: () => const ImagePage(),
    ),
    GetPage(
      name: RouteNames.stylesInputs,
      page: () => const InputsPage(),
    ),
    GetPage(
      name: RouteNames.stylesOther,
      page: () => const OtherPage(),
    ),
    GetPage(
      name: RouteNames.stylesStylesIndex,
      page: () => const StylesIndexPage(),
    ),
    GetPage(
      name: RouteNames.stylesText,
      page: () => const TextPage(),
    ),
    GetPage(
      name: RouteNames.stylesTextForm,
      page: () => const TextFormPage(),
    ),
    GetPage(
      name: RouteNames.systemHome,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouteNames.systemLogin,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RouteNames.systemMain,
      page: () => const MainPage(),
    ),
    GetPage(
      name: RouteNames.systemSplash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RouteNames.systemUserAgreement,
      page: () => const UserAgreementPage(),
    ),
    GetPage(
      name: RouteNames.systemWelcome,
      page: () => const WelcomePage(),
    ),
  ];
}
