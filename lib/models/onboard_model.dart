class OnboardModel {
  final String image;
  final String title;
  final String description;

  const OnboardModel(
      {required this.image, required this.title, required this.description});

  static List<OnboardModel> generatedItem = [
    const OnboardModel(
      image: "assets/images/onboard-1.jpg",
      title: "Find Inspiring Reads",
      description:
          "Explore blogs that spark ideas, knowledge, and inspiration—anytime, anywhere.",
    ),
    const OnboardModel(
      image: "assets/images/onboard-2.jpg",
      title: "Browse Your Interests",
      description:
          "Find blogs tailored to your favorite topics and discover new ideas that captivate you.",
    ),
    const OnboardModel(
      image: "assets/images/onboard-3.jpg",
      title: "Share What You Love",
      description:
          "Easily share inspiring blogs with your friends and community.",
    ),
  ];
}
