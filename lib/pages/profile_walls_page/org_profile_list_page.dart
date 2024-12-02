import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/models/wishwall/wishwall_profiles_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/styles.dart';
import '../../providers/wishwall_providers.dart';
import 'org_profile_wall_page.dart';

class OrgProfileListPage extends StatefulWidget {
  const OrgProfileListPage({super.key});

  @override
  State<OrgProfileListPage> createState() => _OrgProfileListPageState();
}

class _OrgProfileListPageState extends State<OrgProfileListPage> {
  @override
  void initState() {
    super.initState();
    context.read<WishWallProviders>().getOrgProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organization Profile')),
      body: Consumer<WishWallProviders>(builder: (context, provider, __) {
        return provider.orgProfiles.isEmpty
            ? const Center(child: CircularProgressIndicator.adaptive())
            : GridView.builder(
                itemCount: provider.orgProfiles.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 190.0,
                ),
                itemBuilder: (context, index) {
                  final item = provider.orgProfiles[index];
                  return ListIndProfileItem(item: item);
                },
              );
      }),
    );
  }
}

class ListIndProfileItem extends StatelessWidget {
  const ListIndProfileItem({super.key, required this.item});

  final OrgProfileModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => OrgProfileWallPage(profileId: item.id))),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          color: Colors.white,
          border: Border.all(color: AppThemes.borderTheme),
        ),
        child: Column(
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
                border: Border.all(color: AppThemes.borderTheme),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(item.profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              item.orgName,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const SizedBox(height: 6.0),
            Text(item.industry,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black54)),
            const SizedBox(height: 2.0),
            Text(item.orgAddress,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
