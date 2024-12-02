import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/job_page/job_post_page.dart';
import 'package:digitalksp/providers/jobs_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/jobs/jobs_models.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  @override
  void initState() {
    super.initState();
    context.read<JobsProviders>().getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jobs')),
      body: Consumer<JobsProviders>(builder: (context, provider, __) {
        return ListView.builder(
          itemCount: provider.jobModel.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            final item = provider.jobModel[index];
            return Padding(
              padding: EdgeInsets.only(
                  bottom: index == provider.jobModel.length - 1 ? 0.0 : 10.0),
              child: ListJobItem(item: item),
            );
          },
        );
      }),
    );
  }
}

class ListJobItem extends StatelessWidget {
  const ListJobItem({super.key, required this.item});

  final JobModels item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => JobPostPage(jobId: item.id))),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          color: Colors.white,
          border: Border.all(color: AppThemes.borderTheme),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.grey.shade100,
                  child: SvgPicture.asset(
                    'assets/icons/office-outlined.svg',
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    colorFilter:
                        ColorFilter.mode(Colors.grey.shade500, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.jobTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        item.companyName,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            _buildItem(context,
                icon: 'assets/icons/briefcase-outlined.svg',
                label: item.experience),
            const SizedBox(height: 6.0),
            _buildItem(context,
                icon: 'assets/icons/location-outlined.svg',
                label: item.location),
            const SizedBox(height: 14.0),
            Text(
                DateFormat('d MMM, yyyy').format(DateTime.parse(item.postedOn)),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey)),
          ],
        ),
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
