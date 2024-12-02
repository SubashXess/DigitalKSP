import 'package:digitalksp/models/notification_models.dart';
import 'package:flutter/material.dart';
import 'components/notification_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final List<NotificationModels> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = NotificationModels.generatedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Page')),
      body: _notifications.isEmpty
          ? Container(
              padding: const EdgeInsets.all(24.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No notifications',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10.0),
                  Text('You don\'t have any notification\nat this time',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _notifications.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                final item = _notifications[index];
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index == _notifications.length - 1 ? 0.0 : 10.0),
                  child: NotificationItem(item: item),
                );
              },
            ),
    );
  }
}
