import 'package:app_links/app_links.dart';
import 'package:digitalksp/components/empty_state.dart';
import 'package:digitalksp/pages/author_page/author_page.dart';
import 'package:digitalksp/pages/profile_walls_page/ind_profile_walls_page.dart';
import 'package:digitalksp/pages/profile_walls_page/org_profile_wall_page.dart';
import 'package:flutter/material.dart';
import '../pages/blog_post_page/blog_post_page.dart';

class DeepLinkHandler {
  static final DeepLinkHandler _instance = DeepLinkHandler._internal();
  factory DeepLinkHandler() => _instance;
  DeepLinkHandler._internal();

  final AppLinks _appLinks = AppLinks();

  void initialize(context) {
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        _handleDeepLink(uri, context);
      }
    });

    _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri, context);
    });
  }

  void _handleDeepLink(Uri uri, BuildContext context) {
    final String path = uri.path;

    if (path.startsWith('/blogs')) {
      final blogId = uri.queryParameters['id'];
      if (blogId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlogPostPage(blogId: blogId),
          ),
        );
      } else {
        _navigateToErrorPage(context, "Missing blog ID");
      }
    } else if (path.startsWith('/authors')) {
      final authorId = uri.queryParameters['id'];
      if (authorId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuthorPage(authorId: authorId),
          ),
        );
      } else {
        _navigateToErrorPage(context, "Missing author ID");
      }
    } else if (path.startsWith('/ind-profile')) {
      final profileId = uri.queryParameters['id'];
      if (profileId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => IndProfileWallPage(profileId: profileId),
          ),
        );
      } else {
        _navigateToErrorPage(context, "Missing profile ID");
      }
    } else if (path.startsWith('/org-profile')) {
      final profileId = uri.queryParameters['id'];
      if (profileId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrgProfileWallPage(profileId: profileId),
          ),
        );
      } else {
        _navigateToErrorPage(context, "Missing profile ID");
      }
    } else {
      _navigateToErrorPage(context, "Invalid path");
    }
  }

  void _navigateToErrorPage(BuildContext context, String errorMessage) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const PageNotFound(),
      ),
      (route) => false,
    );
  }
}
