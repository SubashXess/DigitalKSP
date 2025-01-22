import 'dart:async';
import 'package:digitalksp/providers/search_providers.dart';
import 'package:digitalksp/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'components/author_list.dart';
import 'components/blog_list.dart';
import 'components/category_item.dart';
import 'components/job_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _searchController;
  late final FocusNode _searchNode;

  // final _debouncer = Debouncer(milliseconds: 2400);
  Timer? _debouncer;

  bool _hasSearched = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_onListen);
    _searchNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchController.removeListener(_onListen);
    _searchNode.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  void _onListen() {
    setState(() {});
  }

  // _onSearchChanged(String query) async {
  //   if (_debouncer?.isActive ?? false) _debouncer?.cancel();

  //   _debouncer = Timer(
  //     const Duration(milliseconds: 600),
  //     () {
  //       setState(() {
  //         _isLoading = true;
  //         _hasSearched = true;
  //       });
  //       if (query.length > 2) {
  //         _debouncer?.cancel();
  //         context
  //             .read<SearchProviders>()
  //             .getSearchResult(query: query)
  //             .then((_) {
  //           setState(() {
  //             _isLoading = false;
  //           });
  //         });
  //       }
  //     },
  //   );

  //   // final String trimQuery = query.toLowerCase().trim();

  //   // if (trimQuery.length > 2) {
  //   //   _debouncer.run(() {
  //   // setState(() {
  //   //   _isLoading = true;
  //   //   _hasSearched = true;
  //   // });
  //   //     context.read<SearchProviders>().getSearchResult(query: query).then((_) {
  //   //       setState(() {
  //   //         _isLoading = false;
  //   //       });
  //   //     });
  //   //   });
  //   // }
  // }

  _onSearchChanged(String query) async {
    if (_debouncer?.isActive ?? false) _debouncer?.cancel();

    _debouncer = Timer(
      const Duration(milliseconds: 1000),
      () {
        if (query.isEmpty) {
          // If query is empty, reset state and stop loading
          setState(() {
            _isLoading = false;
            _hasSearched = false;
          });
          context.read<SearchProviders>().getSearchResult(query: "");
          return;
        }

        // Handle non-empty query

        if (query.length > 2) {
          setState(() {
            _isLoading = true;
            _hasSearched = true;
          });
          _debouncer?.cancel();
          context
              .read<SearchProviders>()
              .getSearchResult(query: query)
              .then((_) {
            setState(() {
              _isLoading = false;
            });
          });
        }
      },
    );
  }

  void _resetState() {
    setState(() {
      _hasSearched = false;
      _isLoading = false;
      _searchController.clear();
    });
    context.read<SearchProviders>().getSearchResult(query: '');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          toolbarHeight: 92.0,
          leading: BackButton(onPressed: () {
            _resetState();
            Navigator.pop(context);
          }),
          title: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
            child: RoundedFormField(
              controller: _searchController,
              node: _searchNode,
              hintText: 'Search your blog, category, author, profile etc...',
              capitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              maxLength: 60,
              textInputAction: TextInputAction.search,
              prefixIcon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 24.0,
                height: 24.0,
                fit: BoxFit.scaleDown,
                colorFilter: _searchNode.hasFocus
                    ? ColorFilter.mode(
                        Theme.of(context).primaryColor, BlendMode.srcIn)
                    : null,
              ),
              suffixIcon:
                  _searchController.text.isNotEmpty && _searchNode.hasFocus
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/close.svg',
                            width: 20.0,
                            height: 20.0,
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                          ),
                        )
                      : null,
              onChanged: _onSearchChanged,
            ),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (!_hasSearched) {
      return Container(
        padding: const EdgeInsets.all(40.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search Now',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Start typing to search for blogs, categories, authors, profiles and jobs',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black54),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Consumer<SearchProviders>(
      builder: (_, provider, __) {
        if (provider.searchModel == null ||
            (provider.searchModel!.category.isEmpty &&
                provider.searchModel!.author.isEmpty &&
                provider.searchModel!.blog.isEmpty &&
                provider.searchModel!.job.isEmpty)) {
          return Container(
            padding: const EdgeInsets.all(50.0),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Result Found',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'We can\'t find any result matching your search',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (provider.searchModel!.category.isNotEmpty)
                SearchCategorySection(items: provider.searchModel!.category),
              if (provider.searchModel!.author.isNotEmpty)
                SearchAuthorSection(items: provider.searchModel!.author),
              if (provider.searchModel!.blog.isNotEmpty)
                SearchBlogSection(items: provider.searchModel!.blog),
              if (provider.searchModel!.job.isNotEmpty)
                SearchJobSection(items: provider.searchModel!.job),
            ],
          ),
        );
      },
    );
  }
}
