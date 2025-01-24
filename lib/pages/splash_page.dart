import 'dart:async';
import 'package:digitalksp/constants/app_config.dart';
import 'package:digitalksp/pages/homepage/homepage.dart';
import 'package:digitalksp/pages/onboard_page/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/deep_link_handler.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
    _initializeApp(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeApp(context) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('onboard-page') ?? true;

    await Future.delayed(const Duration(seconds: 2));
    DeepLinkHandler().initialize(context);

    if (mounted) {
      if (isFirstTime) {
        _navigateToOnboard();
      } else {
        _navigateToHome();
      }
    }
  }

  void _navigateToOnboard() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const OnboardPage()),
      (route) => false,
    );
  }

  void _navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: 'Powered by ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black54),
              ),
              TextSpan(
                text: 'DDN Enterprise',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                AppConfig.instance.appIcon,
                width: MediaQuery.of(context).size.width * 0.50,
              ),
            ),
            const SizedBox(height: 12.0),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  AppConfig.instance.appName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      color: const Color(0xFF3C2870)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
