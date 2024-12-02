import 'package:digitalksp/constants/app_config.dart';
import 'package:digitalksp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/urls.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.initialize(
    appName: 'DigitalKSP',
    flavorType: FlavorType.STAGING,
    baseUrl: 'http://192.168.29.168/digitalksp',
    appIcon: 'assets/staging-digital-ksp-logo.png',
  );

  ApiRequest.initialize(baseUrl: AppConfig.instance.baseUrl);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

// run -> flutter run --target lib/main_staging.dart --flavor staging