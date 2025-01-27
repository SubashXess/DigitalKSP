import 'package:digitalksp/pages/homepage/homepage.dart';
import 'package:digitalksp/widgets/buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future showEmptyState(
  BuildContext context, {
  required String icon,
  String header = 'Header',
  String subtitle = 'Subtitle',
  String buttonText = 'Label',
  required VoidCallback onPressed,
  VoidCallback? onCancelled,
}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isDismissible: false,
    builder: (context) => Stack(
      alignment: Alignment.topCenter,
      children: [
        SvgPicture.asset(
          icon,
          width: 240.0,
          height: 240.0,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.topRight,
          child: ActionButton(
            icon: 'assets/icons/close.svg',
            onTap: () => Navigator.pop(context),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(16.0 * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                header,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 24.0),
              RoundedButton(label: buttonText, onTap: onPressed),
            ],
          ),
        ),
      ],
    ),
  );
}

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorLight,

      extendBody: true,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(24.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/404-error-state.svg',
              height: 240.0,
            ),
            const SizedBox(height: 24.0),
            Text(
              'Oops! Page Not Found.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 28.0),
            ),
            const SizedBox(height: 14.0),
            Text(
              'The page you\'re looking for doesn\'t exist or has been moved.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black45),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: size.width,
        padding: const EdgeInsets.all(24.0),
        child: RoundedButton(
            label: 'Back to Home',
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false)),
      ),
    );
  }
}
