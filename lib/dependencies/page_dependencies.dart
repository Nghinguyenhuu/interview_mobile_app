import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:interview_mobile_app/pages/phone/main/main.dart';

import '../pages/pages.dart';
import '../router/router.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => SplashPage(injector()), instanceName: Routes.splash);
    injector.registerFactory<Widget>(() => MainPage(), instanceName: Routes.main);
  }
}
