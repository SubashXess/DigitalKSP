import 'package:digitalksp/constants/app_config.dart';
import 'package:digitalksp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/urls.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.initialize(
    appName: 'DigitalKSP',
    flavorType: FlavorType.PRODUCTION,
    baseUrl: 'https://www.digitalksp.com',
    appIcon: 'assets/digital-ksp-logo.png',
  );

  ApiRequest.initialize(baseUrl: AppConfig.instance.baseUrl);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

// run -> flutter run --target lib/main_production.dart --flavor production