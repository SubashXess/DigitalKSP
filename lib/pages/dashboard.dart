import 'package:digitalksp/models/navbar_model.dart';
import 'package:digitalksp/pages/explore_page/explore_by_topic.dart';
import 'package:digitalksp/pages/homepage/homepage.dart';
import 'package:digitalksp/pages/profile_page/profile_page.dart';
import 'package:digitalksp/pages/search_page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/miscellaneous_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final List<NavBarItemModel> _navBarItems;

  final List<Widget> _pages = [
    const HomePage(),
    const ExploreByTopic(),
    const SearchPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _navBarItems = NavBarItemModel.generatedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        duration: Durations.medium1,
        curve: Curves.easeOut,
        width: double.infinity,
        height: 56.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  color: Colors.black.withOpacity(0.056), width: 0.6)),
        ),
        child:
            Consumer<MiscellaneousProvider>(builder: (context, provider, __) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_navBarItems.length, (index) {
              final item = _navBarItems[index];
              return Expanded(
                child: GestureDetector(
                  onTap: () => provider.onNavBarSelected(index),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56.0,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          item.icon,
                          fit: BoxFit.scaleDown,
                          width: 20.0,
                          height: 20.0,
                          alignment: Alignment.center,
                          colorFilter: ColorFilter.mode(
                              index == provider.bottomNavIndex
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade400,
                              BlendMode.srcIn),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            item.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: index == provider.bottomNavIndex
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade400),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
      body: Consumer<MiscellaneousProvider>(builder: (context, provider, __) {
        return IndexedStack(
          index: provider.bottomNavIndex,
          children: _pages,
        );
      }),
    );
  }
}
