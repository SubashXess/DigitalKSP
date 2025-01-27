import 'dart:io';

import 'package:digitalksp/constants/app_config.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/models/drawer_model.dart';
import 'package:digitalksp/pages/about_us_page/about_us_page.dart';
import 'package:digitalksp/pages/author_page/author_list_page.dart';
import 'package:digitalksp/pages/job_page/job_list_page.dart';
import 'package:digitalksp/pages/profile_walls_page/org_profile_list_page.dart';
import 'package:digitalksp/utilities/utilities.dart';
import 'package:digitalksp/widgets/buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';
import '../../profile_walls_page/ind_profile_list_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.size, required this.items});

  final Size size;
  final List<DrawerModel> items;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      clipBehavior: Clip.none,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppConfig.instance.appIcon,
                    height: 80.0,
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Digital KSP',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: const Color(0xFF3C2870)),
                  ),
                ],
              ),
            ),
            Divider(height: 40.0, color: Colors.grey.shade200),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerItem(
                  size: size,
                  title: items[0].title,
                  icon: items[0].icon,
                  onTap: () => _onItemPressed(context, 0),
                ),
                DrawerItem(
                  size: size,
                  title: items[1].title,
                  icon: items[1].icon,
                  onTap: () => _onItemPressed(context, 1),
                ),
                DrawerItem(
                  size: size,
                  title: items[2].title,
                  icon: items[2].icon,
                  onTap: () => _onItemPressed(context, 2),
                ),
                DrawerItem(
                  size: size,
                  title: items[3].title,
                  icon: items[3].icon,
                  onTap: () => _onItemPressed(context, 3),
                ),
                DrawerItem(
                  size: size,
                  title: items[4].title,
                  icon: items[4].icon,
                  onTap: () => _onItemPressed(context, 4),
                ),
                DrawerItem(
                  size: size,
                  title: items[5].title,
                  icon: items[5].icon,
                  onTap: () => _onItemPressed(context, 5),
                ),
                DrawerItem(
                  size: size,
                  title: items[6].title,
                  icon: items[6].icon,
                  onTap: () => _onItemPressed(context, 6),
                ),
                DrawerItem(
                  size: size,
                  title: items[7].title,
                  icon: items[7].icon,
                  onTap: () => _onItemPressed(context, 7),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Powered by ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black54)),
                    TextSpan(
                        text: 'DDN Enterprise',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemPressed(BuildContext context, int index) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AuthorListPage()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const JobListPage()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const IndProfileListPage()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const OrgProfileListPage()));
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AboutUsPage()));
        break;
      case 6:
        Utilities.shareIt(context,
            text:
                "Hi! I'm using the Digital KSP app, and it's awesome! Give it a try: $PLAY_STORE_LINK",
            url: '',
            subject: '');
        break;
      case 7:
        // Open dialogs
        showDialog(
          context: context,
          useSafeArea: true,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              insetPadding: const EdgeInsets.all(24.0),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadius * 2.0)),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.086),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            bottom: -20.0,
                            child: SvgPicture.asset(
                              Platform.isIOS
                                  ? 'assets/icons/ios-rating.svg'
                                  : 'assets/icons/android-rating.svg',
                              width: 180.0,
                              height: 180.0,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'We Value Your Thoughts!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Help us grow by sharing your thoughts. Your feedback makes a difference!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black87, fontSize: 13.0),
                    ),
                    const SizedBox(height: 20.0),
                    RoundedButton(
                      label: 'Rate us on Playstore',
                      onTap: () {},
                    ),
                    const SizedBox(height: 14.0),
                    SmallTextButton(
                      label: 'Maybe later',
                      labelColor: Colors.black54,
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
        break;
    }
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.size,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final Size size;
  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadius - 2.0),
                color: Theme.of(context).primaryColor.withOpacity(0.05),
              ),
              child: SvgPicture.asset(
                icon,
                width: 20.0,
                height: 20.0,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(title, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
