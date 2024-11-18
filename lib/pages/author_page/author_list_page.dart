import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/author_page/author_page.dart';
import 'package:digitalksp/providers/author_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorListPage extends StatefulWidget {
  const AuthorListPage({super.key});

  @override
  State<AuthorListPage> createState() => _AuthorListPageState();
}

class _AuthorListPageState extends State<AuthorListPage> {
  @override
  void initState() {
    context.read<AuthorProviders>().getAuthors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Authors'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Text(
              //     'Our Authors',
              //     style: Theme.of(context)
              //         .textTheme
              //         .headlineMedium
              //         ?.copyWith(fontWeight: FontWeight.w600),
              //   ),
              // ),
              const SizedBox(height: 20.0),
              Consumer<AuthorProviders>(builder: (context, provider, _) {
                return ListView.separated(
                  itemCount: provider.author.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  clipBehavior: Clip.none,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final author = provider.author[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    AuthorPage(authorId: author.id)));
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius),
                                color: Colors.grey.shade200,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        author.photoUrl),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                author.blogCount == '0'
                                    ? const SizedBox()
                                    : Text('${author.blogCount} Blogs',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.grey)),
                                const SizedBox(height: 4.0),
                                Text(author.name,
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(height: 0.0, color: Colors.grey.shade200),
                  ),
                );
              }),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
