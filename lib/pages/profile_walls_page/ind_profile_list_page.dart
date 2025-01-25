import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/profile_walls_page/ind_profile_walls_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../models/wishwall/wishwall_profiles_model.dart';
import '../../providers/wishwall_providers.dart';

class IndProfileListPage extends StatefulWidget {
  const IndProfileListPage({super.key});

  @override
  State<IndProfileListPage> createState() => _IndProfileListPageState();
}

class _IndProfileListPageState extends State<IndProfileListPage> {
  @override
  void initState() {
    super.initState();
    context.read<WishWallProviders>().getIndProfiles(limit: '100');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Professional Profile')),
      body: Consumer<WishWallProviders>(builder: (context, provider, __) {
        return provider.indProfiles.isEmpty
            ? const Center(child: CircularProgressIndicator.adaptive())
            : GridView.builder(
                itemCount: provider.indProfiles.length,
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
                  final item = provider.indProfiles[index];
                  return ListIndProfileItem(item: item);
                },
              );
      }),
    );
  }
}

class ListIndProfileItem extends StatelessWidget {
  const ListIndProfileItem({super.key, required this.item});

  final IndProfileModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => IndProfileWallPage(profileId: item.id))),
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
              item.fullName,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const SizedBox(height: 6.0),
            _buildItem(context,
                icon: 'assets/icons/briefcase-outlined.svg',
                label: item.experienceYears),
            const SizedBox(height: 6.0),
            _buildItem(context,
                icon: 'assets/icons/location-outlined.svg',
                label: item.address),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context,
      {required String icon, required String label}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Flexible(
          child: Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
