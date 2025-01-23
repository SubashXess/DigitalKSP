import 'package:digitalksp/constants/constants.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/splash_page.dart';
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

import 'pages/demo_page.dart';

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