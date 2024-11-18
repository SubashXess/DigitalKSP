class NavBarItemModel {
  final String icon;
  final String title;

  const NavBarItemModel({required this.icon, required this.title});

  static List<NavBarItemModel> generatedItem = [
    const NavBarItemModel(icon: 'assets/icons/home.svg', title: 'Home'),
    const NavBarItemModel(icon: 'assets/icons/explore.svg', title: 'Explore'),
    const NavBarItemModel(icon: 'assets/icons/job-filled.svg', title: 'Jobs'),
    const NavBarItemModel(
        icon: 'assets/icons/profile-wall.svg', title: 'Profile Wall'),
  ];
}
