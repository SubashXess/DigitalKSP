import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/job_page/apply_job_page.dart';
import 'package:digitalksp/widgets/buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

import '../../providers/jobs_providers.dart';
import '../../utilities/utilities.dart';

class JobPostPage extends StatefulWidget {
  const JobPostPage({super.key, required this.jobId});

  final String jobId;

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  @override
  void initState() {
    super.initState();
    context.read<JobsProviders>().getJobPost(id: widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProviders>(builder: (context, provider, __) {
      return Scaffold(
        appBar: provider.jobPostModel == null
            ? null
            : AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconButton(
                      onPressed: () => Utilities.shareIt(context,
                          url: 'https://digitalksp.com/jobs?id=${widget.jobId}',
                          subject: provider.jobPostModel!.jobTitle,
                          text: provider.jobPostModel?.jobTitle),
                      icon: SvgPicture.asset(
                        'assets/icons/share-outlined.svg',
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: provider.jobPostModel == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RoundedButton(
                      label: 'Apply for this job',
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ApplyJobPage(
                                  jobDetails: provider.jobPostModel))),
                    )
                  ],
                ),
              ),
        body: provider.jobPostModel == null
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.jobPostModel!.jobTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/office-outlined.svg',
                          width: 20.0,
                          height: 20.0,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.36), BlendMode.srcIn),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            provider.jobPostModel!.companyName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.black.withOpacity(0.56),
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/location-outlined.svg',
                          width: 20.0,
                          height: 20.0,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.36), BlendMode.srcIn),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            provider.jobPostModel!.location,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.black.withOpacity(0.56),
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.borderRadius),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.056)),
                        color: Colors.white,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/briefcase-outlined.svg',
                                    width: 20.0,
                                    height: 20.0,
                                    alignment: Alignment.center,
                                    fit: BoxFit.scaleDown,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black54, BlendMode.srcIn),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    'Experience',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    provider.jobPostModel!.experience,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                                color: Colors.black.withOpacity(0.056)),
                            Expanded(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/wallet-outlined.svg',
                                    width: 20.0,
                                    height: 20.0,
                                    alignment: Alignment.center,
                                    fit: BoxFit.scaleDown,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black54, BlendMode.srcIn),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    'Salary',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    provider.jobPostModel!.salary,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'About the company',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10.0),
                    HtmlWidget(provider.jobPostModel!.aboutEmployer),
                    const SizedBox(height: 24.0),
                    HtmlWidget(provider.jobPostModel!.rolesResponsibilities),
                  ],
                ),
              ),
      );
    });
  }
}
