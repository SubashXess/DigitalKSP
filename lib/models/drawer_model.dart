class DrawerModel {
  final String title;
  final String icon;

  const DrawerModel({required this.title, required this.icon});

  static List<DrawerModel> generatedItem = [
    const DrawerModel(title: 'Home', icon: 'assets/icons/home.svg'),
    const DrawerModel(title: 'Our Authors', icon: 'assets/icons/author.svg'),
    const DrawerModel(
        title: 'Job Posted', icon: 'assets/icons/briefcase-outlined.svg'),
    const DrawerModel(
        title: 'Individual Profile', icon: 'assets/icons/user-outlined-2.svg'),
    const DrawerModel(
        title: 'Organization Profile',
        icon: 'assets/icons/office-outlined.svg'),
    const DrawerModel(title: 'About us', icon: 'assets/icons/about.svg'),
    const DrawerModel(title: 'Rate us', icon: 'assets/icons/star.svg'),
  ];
}
