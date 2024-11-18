import 'package:digitalksp/constants/constants.dart';
import 'package:digitalksp/providers/author_providers.dart';
import 'package:digitalksp/providers/blog_providers.dart';
import 'package:digitalksp/providers/categories_provider.dart';
import 'package:digitalksp/providers/jobs_providers.dart';
import 'package:digitalksp/providers/miscellaneous_provider.dart';
import 'package:digitalksp/providers/wishwall_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MiscellaneousProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => AuthorProviders()),
        ChangeNotifierProvider(create: (_) => BlogProviders()),
        ChangeNotifierProvider(create: (_) => WishWallProviders()),
        ChangeNotifierProvider(create: (_) => JobsProviders()),
      ],
      builder: (context, child) => MaterialApp(
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.orange, scaffoldBackgroundColor: Colors.white),
        home: const Dashboard(),
        // home: const OrgProfileWallPage(profileId: '9'),
      ),
    );
  }
}
