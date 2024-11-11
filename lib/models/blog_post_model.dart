class SocialMediaModel {
  final String title;
  final String url;
  final String icon;

  const SocialMediaModel(
      {required this.title, required this.url, required this.icon});

  static final List<SocialMediaModel> generatedItem = [
    const SocialMediaModel(
        title: 'Facebook',
        url: 'https://www.facebook.com/',
        icon: 'assets/icons/social-media-facebook.svg'),
    const SocialMediaModel(
        title: 'Instagram',
        url: 'https://www.instagram.com/',
        icon: 'assets/icons/social-media-instagram.svg'),
    const SocialMediaModel(
        title: 'X',
        url: 'https://x.com/',
        icon: 'assets/icons/social-media-x.svg'),
    const SocialMediaModel(
        title: 'LinkedIn',
        url: 'https://www.linkedin.com/',
        icon: 'assets/icons/social-media-linkedin.svg'),
    const SocialMediaModel(
        title: 'YouTube',
        url: 'https://www.youtube.com/',
        icon: 'assets/icons/social-media-youtube.svg'),
  ];
}
