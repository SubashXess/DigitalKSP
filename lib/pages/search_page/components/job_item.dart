import 'package:digitalksp/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';
import '../../job_page/job_post_page.dart';

class SearchJobSection extends StatelessWidget {
  const SearchJobSection({super.key, required this.items});

  final List<SearchJobModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('JOB VACANCY',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 20.0),
        SizedBox(
          width: double.infinity,
          height: 168.0,
          child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: EdgeInsets.only(
                    right: index == items.length - 1 ? 0.0 : 10.0),
                child: JobItem(item: item),
              );
            },
          ),
        ),
      ],
    );
  }
}

class JobItem extends StatelessWidget {
  const JobItem({super.key, required this.item});
  final SearchJobModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => JobPostPage(jobId: item.id))),
      child: Container(
        width: 200.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          border: Border.all(color: AppThemes.borderTheme),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.jobTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.0)),
              const SizedBox(height: 4.0),
              Text(item.companyName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black87)),
              const SizedBox(height: 14.0),
              const Spacer(),
              _buildItem(context,
                  icon: 'assets/icons/briefcase-outlined.svg',
                  label: item.experience),
              const SizedBox(height: 6.0),
              _buildItem(context,
                  icon: 'assets/icons/location-outlined.svg',
                  label: item.location),
              const SizedBox(height: 14.0),
              const Spacer(),
              Text(
                  DateFormat('d MMM, yyyy')
                      .format(DateTime.parse(item.postedOn)),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey)),
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
