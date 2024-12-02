import 'dart:async';

import 'package:digitalksp/models/onboard_model.dart';
import 'package:digitalksp/pages/homepage/homepage.dart';
import 'package:digitalksp/widgets/buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  late final PageController _pageController;
  int _pageIndex = 0;
  Timer? _timer;

  late final List<OnboardModel> _onboardItem;

  @override
  void initState() {
    super.initState();
    _onboardItem = OnboardModel.generatedItem;
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageIndex < 2) {
        _pageIndex++;
      } else {
        _pageIndex = 0;
      }

      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemCount: _onboardItem.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final item = _onboardItem[index];
                    return OnBoardContent(
                      size: size,
                      title: item.title,
                      description: item.description,
                      image: item.image,
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  _onboardItem.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(
                      isActive: index == _pageIndex,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: RoundedButton(
                  label: 'Get Started',
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('onboard-page', false);
                    _onNavigate();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _onNavigate() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }
}

class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.description,
  });

  final Size size;
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Image.asset(
            image,
            width: size.width,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 14),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({this.isActive = false, super.key});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.white,
        border:
            isActive ? null : Border.all(color: Theme.of(context).primaryColor),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
