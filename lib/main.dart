import 'package:digitalksp/constants/constants.dart';
import 'package:digitalksp/pages/author_page/author_list_page.dart';
import 'package:digitalksp/providers/author_providers.dart';
import 'package:digitalksp/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/author_page/author_page.dart';
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
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => AuthorProviders()),
      ],
      builder: (context, child) => MaterialApp(
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.orange, scaffoldBackgroundColor: Colors.white),
        // home: const Dashboard(),
        home: const AuthorListPage(),
      ),
    );
  }
}
