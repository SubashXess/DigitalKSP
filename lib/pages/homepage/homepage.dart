import 'package:digitalksp/models/drawer_model.dart';
import 'package:digitalksp/pages/homepage/components/carousel_blog.dart';
import 'package:digitalksp/pages/homepage/components/category_item.dart';
import 'package:digitalksp/pages/homepage/components/drawer.dart';
import 'package:digitalksp/pages/homepage/components/featured_blog.dart';
import 'package:digitalksp/pages/homepage/components/job_item.dart';
import 'package:digitalksp/pages/homepage/components/latest_blog.dart';
import 'package:digitalksp/pages/homepage/components/popular_blog.dart';
import 'package:digitalksp/pages/search_page/search_page.dart';
import 'package:digitalksp/providers/blog_providers.dart';
import 'package:digitalksp/providers/categories_provider.dart';
import 'package:digitalksp/providers/jobs_providers.dart';
import 'package:digitalksp/providers/wishwall_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/buttons_widget.dart';
import 'components/blog_list.dart';
import 'components/ind_profile_item.dart';
import 'components/org_profile_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final ScrollController _scrollController;

  bool _hasLoading = true;
  bool _isFetchingMore = false;
  late final List<DrawerModel> _drawerItem;

  int currentPage = 1;
  final int perPage = 12;

  @override
  void initState() {
    super.initState();
    _drawerItem = DrawerModel.generatedItem;
    _scrollController = ScrollController()
      ..addListener(_onScroll); // Use _onScroll here
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  // Scroll listener for infinite scrolling
  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetchingMore) {
      // If we reach the bottom and we're not already fetching more data
      _fetchMoreBlogs();
    }
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _hasLoading = true;
    });

    try {
      await Future.wait([
        context.read<BlogProviders>().getBlogs(type: 'Front Banner', limit: 12),
        context.read<BlogProviders>().getBlogs(type: 'Latest', limit: 12),
        context.read<BlogProviders>().getBlogs(type: 'Featured', limit: 12),
        context.read<BlogProviders>().getBlogs(type: 'Most Popular', limit: 12),
        context.read<BlogProviders>().getBlogs(type: 'Normal', limit: 12),
        context.read<BlogProviders>().getBlogs(type: 'Recent', limit: 4),
        context.read<WishWallProviders>().getIndProfiles(),
        context.read<WishWallProviders>().getOrgProfiles(),
        context.read<CategoriesProvider>().getCategory(),
        context.read<JobsProviders>().getJobs(),
      ]);
    } catch (e) {
      // Handle error (e.g., show a snack bar or a dialog)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load data: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _hasLoading = false;
        });
      }
    }
  }

  Future<void> _fetchMoreBlogs() async {
    if (_isFetchingMore)
      return; // Prevent fetching more while data is being fetched

    setState(() {
      _isFetchingMore = true;
    });

    try {
      currentPage++;
      await context
          .read<BlogProviders>()
          .getBlogs(type: 'Normal', limit: perPage, page: currentPage);
    } catch (e) {
      // Handle error for fetching more blogs
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading more blogs: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isFetchingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(size: size, items: _drawerItem),
      appBar: _hasLoading
          ? null
          : AppBar(
              backgroundColor: Colors.grey.shade50,
              toolbarHeight: 68.0,
              titleSpacing: 0.0,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0.0,
              title: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      return ActionButton(
                        icon: 'assets/icons/hamburger-menu.svg',
                        backgroundColor: Theme.of(context).primaryColorDark,
                        foregroundColor: Colors.white,
                        onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      );
                    }),
                    Row(
                      children: [
                        ActionButton(
                          icon: 'assets/icons/search.svg',
                          border: true,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SearchPage())),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      body: _hasLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Consumer<CategoriesProvider>(
                        builder: (context, provider, __) {
                      return provider.categories.isEmpty
                          ? const SizedBox()
                          : CategoryItemList(items: provider.categories);
                    }),
                    const SizedBox(height: 20.0),
                    Consumer<BlogProviders>(builder: (_, provider, __) {
                      return provider.recentBlogModel.isEmpty
                          ? const SizedBox()
                          : CarouselBlog(items: [
                              ...provider.recentBlogModel,
                              ...provider.frontBannerBlogModel
                            ]);
                    }),
                    const SizedBox(height: 20.0),
                    Consumer<BlogProviders>(builder: (_, provider, __) {
                      return LatestBlogList(items: provider.latestBlogModel);
                    }),
                    const SizedBox(height: 20.0),
                    Consumer<BlogProviders>(builder: (_, provider, __) {
                      return FeaturedBlog(
                          size: size, items: provider.featuredBlogModel);
                    }),
                    const SizedBox(height: 20.0),
                    Consumer<JobsProviders>(builder: (context, provider, __) {
                      return JobSection(items: provider.jobModel);
                    }),
                    const SizedBox(height: 20.0),
                    Consumer<BlogProviders>(builder: (_, provider, __) {
                      return PopularBlogList(items: provider.popularBlogModel);
                    }),
                    const SizedBox(height: 20.0),
                    Consumer<WishWallProviders>(builder: (_, provider, __) {
                      return IndProfileList(items: provider.indProfiles);
                    }),
                    const SizedBox(height: 20.0),
                    Consumer<WishWallProviders>(builder: (_, provider, __) {
                      return OrgProfileList(items: provider.orgProfiles);
                    }),
                    const SizedBox(height: 20.0),
                    Consumer<BlogProviders>(builder: (_, provider, __) {
                      return BlogList(items: provider.normalBlogModel);
                    }),
                    _isFetchingMore
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox(),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
    );
  }
}
