class NotificationModels {
  final String id;
  final String authorImage;
  final String title;
  final String coverImage;
  final String publishedDate;
  final bool read;

  const NotificationModels({
    required this.id,
    required this.authorImage,
    required this.title,
    required this.coverImage,
    required this.publishedDate,
    this.read = false,
  });

  static List<NotificationModels> generatedItem = [
    const NotificationModels(
      id: '1',
      authorImage:
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'Exploring Flutter: A Beginner\'s Guide',
      coverImage:
          'https://images.pexels.com/photos/775201/pexels-photo-775201.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-08-18',
      read: false,
    ),
    const NotificationModels(
      id: '2',
      authorImage:
          'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'Efficient UI Development with Flutter Widgets',
      coverImage:
          'https://images.pexels.com/photos/574071/pexels-photo-574071.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-09-01',
      read: false,
    ),
    const NotificationModels(
      id: '3',
      authorImage:
          'https://images.pexels.com/photos/315320/pexels-photo-315320.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'Understanding State Management in Flutter',
      coverImage:
          'https://images.pexels.com/photos/461199/pexels-photo-461199.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-09-10',
      read: true,
    ),
    const NotificationModels(
      id: '4',
      authorImage:
          'https://images.pexels.com/photos/1103537/pexels-photo-1103537.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'The Power of Custom Animations in Flutter',
      coverImage:
          'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-09-15',
      read: true,
    ),
    const NotificationModels(
      id: '5',
      authorImage:
          'https://images.pexels.com/photos/129730/pexels-photo-129730.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'Integrating APIs into Your Flutter App',
      coverImage:
          'https://images.pexels.com/photos/209151/pexels-photo-209151.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-09-20',
      read: true,
    ),
    const NotificationModels(
      id: '6',
      authorImage:
          'https://images.pexels.com/photos/129994/pexels-photo-129994.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'How to Debug Your Flutter Application',
      coverImage:
          'https://images.pexels.com/photos/386196/pexels-photo-386196.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-09-25',
      read: true,
    ),
    const NotificationModels(
      id: '7',
      authorImage:
          'https://images.pexels.com/photos/2599244/pexels-photo-2599244.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'Best Practices for Flutter App Architecture',
      coverImage:
          'https://images.pexels.com/photos/169573/pexels-photo-169573.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-10-01',
      read: true,
    ),
    const NotificationModels(
      id: '8',
      authorImage:
          'https://images.pexels.com/photos/1084401/pexels-photo-1084401.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'Building Responsive Apps in Flutter',
      coverImage:
          'https://images.pexels.com/photos/257897/pexels-photo-257897.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-10-08',
      read: true,
    ),
    const NotificationModels(
      id: '9',
      authorImage:
          'https://images.pexels.com/photos/131053/pexels-photo-131053.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'Working with Flutter SVGs and Icons',
      coverImage:
          'https://images.pexels.com/photos/257830/pexels-photo-257830.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-10-15',
      read: true,
    ),
    const NotificationModels(
      id: '10',
      authorImage:
          'https://images.pexels.com/photos/196640/pexels-photo-196640.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'The Future of Mobile Development with Flutter',
      coverImage:
          'https://images.pexels.com/photos/199604/pexels-photo-199604.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      publishedDate: '2024-10-20',
      read: true,
    ),
  ];
}
