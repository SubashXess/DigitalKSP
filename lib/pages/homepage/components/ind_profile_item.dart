import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/styles.dart';
import '../../../models/wishwall/wishwall_profiles_model.dart';
import '../../profile_walls_page/ind_profile_walls_page.dart';
import 'headline.dart';

class IndProfileList extends StatelessWidget {
  const IndProfileList({super.key, required this.items});

  final List<IndProfileModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineSection(
            headline: 'Professional frame', showMore: true, onTap: () {}),
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          height: 166.0,
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
                child: IndiProfileItem(item: items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class IndiProfileItem extends StatelessWidget {
  const IndiProfileItem({super.key, required this.item});

  final IndProfileModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => IndProfileWallPage(profileId: item.id),
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
              Row(
                children: [
                  CircleAvatar(
                    radius: 28.0,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                        CachedNetworkImageProvider(item.profilePhoto),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.fullName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4.0),
                        Text(item.industry,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/graduation-cap.svg',
                    width: 15.0,
                    height: 15.0,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    colorFilter:
                        ColorFilter.mode(Colors.grey.shade500, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                        item.qualification.isNotEmpty
                            ? item.qualification
                            : item.otherQualification,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              _buildItem(context,
                  icon: 'assets/icons/briefcase-outlined.svg',
                  label: item.experienceYears),
              const SizedBox(height: 6.0),
              _buildItem(context,
                  icon: 'assets/icons/location-outlined.svg',
                  label: item.address),
            ]),
      ),
    );
  }

  Widget _buildItem(BuildContext context,
      {required String icon, required String label}) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 15.0,
          height: 15.0,
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
