import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../constants/styles.dart';
import '../../../models/wishwall/wishwall_profiles_model.dart';
import '../../profile_walls_page/org_profile_wall_page.dart';
import 'headline.dart';

class OrgProfileList extends StatelessWidget {
  const OrgProfileList({super.key, required this.items});

  final List<OrgProfileModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineSection(
            headline: 'Organization profile', showMore: true, onTap: () {}),
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          height: 194.0,
          child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: index == items.length - 1 ? 0.0 : 10.0),
                child: OrgProfileItem(item: items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class OrgProfileItem extends StatelessWidget {
  const OrgProfileItem({super.key, required this.item});

  final OrgProfileModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrgProfileWallPage(profileId: item.id),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.56,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(item.profilePhoto),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.grey.shade200),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(item.orgName,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 10.0),
            // const Spacer(),
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
