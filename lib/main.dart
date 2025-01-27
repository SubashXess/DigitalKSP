import 'package:digitalksp/constants/constants.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/splash_page.dart';
import 'package:digitalksp/providers/ads_providers.dart';
import 'package:digitalksp/providers/author_providers.dart';
import 'package:digitalksp/providers/blog_providers.dart';
import 'package:digitalksp/providers/categories_provider.dart';
import 'package:digitalksp/providers/internet_provider.dart';
import 'package:digitalksp/providers/jobs_providers.dart';
import 'package:digitalksp/providers/miscellaneous_provider.dart';
import 'package:digitalksp/providers/search_providers.dart';
import 'package:digitalksp/providers/wishwall_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MiscellaneousProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider(context)),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => AuthorProviders()),
        ChangeNotifierProvider(create: (_) => BlogProviders()),
        ChangeNotifierProvider(create: (_) => WishWallProviders()),
        ChangeNotifierProvider(create: (_) => JobsProviders()),
        ChangeNotifierProvider(create: (_) => SearchProviders()),
        ChangeNotifierProvider(create: (_) => AdsProviders()),
      ],
      builder: (context, child) => MaterialApp(
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.instance.lightTheme,

        home: const SplashPage(),
        // home: const DemoPage(),
      ),
    );
  }
}

// Running each flavor on DEBUG mode:
// flutter run -t lib/main.dart --flavor prod
// flutter run -t lib/main_dev.dart --flavor dev

// Running each flavor on PROFILE mode:
// flutter run --profile -t lib/main.dart --flavor prod
// flutter run --profile -t lib/main_dev.dart --flavor dev

// Running each flavor on RELEASE mode:
// flutter run --release -t lib/main.dart --flavor prod
// flutter run --release -t lib/main_dev.dart --flavor dev
// flutter build appbundle --flavor production -t lib/main_production.dart

// adb shell pm get-app-links --user cur your.package.name

// Development SHA-256: 7D:E0:6F:86:1E:4D:71:10:AC:86:CB:74:B9:37:B2:AC:63:E4:AB:49:29:54:13:36:5A:6C:FD:2F:94:FA:48:5C
// Production Release SHA-256: 64:6A:D6:47:82:88:7B:4A:E4:B1:75:F1:86:88:26:87:A9:47:08:D8:74:38:38:60:F2:A5:96:1B:8E:88:B4:C0
// Playstore SHA-256: DA:7B:02:84:51:9E:17:D4:37:28:3E:41:6E:54:EC:E9:EC:64:FC:6F:A3:F9:4A:F7:C7:D9:BF:A1:4B:B9:BC:C9
