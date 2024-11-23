import 'package:digitalksp/constants/app_config.dart';
import 'package:digitalksp/main.dart';
import 'package:flutter/material.dart';

import 'constants/urls.dart';

void main() {
  AppConfig.initialize(
    appName: 'DigitalKSP Development',
    flavorType: FlavorType.DEVELOPMENT,
    baseUrl: 'http://192.168.29.168/digitalksp',
    appIcon: 'assets/development-digital-ksp-logo.png',
  );

  ApiRequest.initialize(baseUrl: AppConfig.instance.baseUrl);

  runApp(const App());
}


// run -> flutter run --target lib/main_development.dart --flavor development