import 'package:digitalksp/models/topics_model.dart';
import 'package:flutter/material.dart';

class ExploreByTopic extends StatefulWidget {
  const ExploreByTopic({super.key});

  @override
  State<ExploreByTopic> createState() => _ExploreByTopicState();
}

class _ExploreByTopicState extends State<ExploreByTopic> {
  late final List<TopicModel> _topic;

  @override
  void initState() {
    _topic = TopicModel.generatedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore by Topics'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.search_rounded),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: _topic.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        clipBehavior: Clip.none,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          final item = _topic[index];
          return Container(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: item.imageUrl.isEmpty
                    ? null
                    : DecorationImage(
                        image: NetworkImage(item.imageUrl), fit: BoxFit.cover)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${item.count} ${item.count == 1 ? 'post' : 'posts'}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
