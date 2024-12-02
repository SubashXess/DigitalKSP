import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../providers/wishwall_providers.dart';

class IndProfileWallPage extends StatefulWidget {
  const IndProfileWallPage({super.key, required this.profileId});

  final String profileId;

  @override
  State<IndProfileWallPage> createState() => _IndProfileWallPageState();
}

class _IndProfileWallPageState extends State<IndProfileWallPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<WishWallProviders>()
        .getIndDetailsProfile(id: widget.profileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  iconSize: 20.0,
                  icon: const Icon(Icons.download_rounded),
                ),
                const SizedBox(width: 4.0),
                IconButton(
                  onPressed: () {},
                  iconSize: 20.0,
                  icon: const Icon(Icons.share),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<WishWallProviders>(builder: (context, provider, __) {
        return provider.indDetailProfile.isEmpty
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 58.0,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: CachedNetworkImageProvider(
                                provider.indDetailProfile.first.profilePhoto),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            provider.indDetailProfile.first.fullName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            provider.indDetailProfile.first.designation,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius),
                                boxShadow: [
                                  AppStyles.boxShadow(
                                    color: Colors.black.withOpacity(0.036),
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Information',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 10.0),
                                _buildInfoItem(context,
                                    label: 'Designation',
                                    value: provider
                                        .indDetailProfile.first.designation),
                                _buildInfoItem(context,
                                    label: 'Current Company',
                                    value: provider
                                        .indDetailProfile.first.currentCompany),
                                _buildInfoItem(context,
                                    label: 'Highest Qualification',
                                    value: provider
                                        .indDetailProfile.first.qualification),
                                _buildInfoItem(context,
                                    label: 'Other Qualification',
                                    value: provider.indDetailProfile.first
                                        .otherQualification),
                                _buildInfoItem(context,
                                    label: 'Address',
                                    value: provider
                                        .indDetailProfile.first.address),
                                _buildInfoItem(context,
                                    label: 'Industry Type',
                                    value: provider
                                        .indDetailProfile.first.industry),
                                _buildInfoItem(context,
                                    label: 'Date of Birth',
                                    value: DateFormat('d MMM, yyyy').format(
                                        DateTime.parse(provider
                                            .indDetailProfile.first.dob))),
                                _buildInfoItem(context,
                                    label: 'Years of Experience',
                                    value: provider.indDetailProfile.first
                                        .experienceYears),
                                _buildInfoItem(context,
                                    label: 'Website',
                                    value: provider.indDetailProfile.first.url),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius),
                                boxShadow: [
                                  AppStyles.boxShadow(
                                    color: Colors.black.withOpacity(0.036),
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contact Information',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 10.0),
                                _buildInfoItem(context,
                                    label: 'Mobile Number',
                                    value:
                                        provider.indDetailProfile.first.mobile),
                                _buildInfoItem(context,
                                    label: 'Email Address',
                                    value:
                                        provider.indDetailProfile.first.email),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About us',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10.0),
                          ReadMoreText(
                            provider.indDetailProfile.first.bio,
                            numLines: 5,
                            readMoreText: 'Read more',
                            readLessText: 'Read less',
                            readMoreTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor),
                            readMoreIconColor: Theme.of(context).primaryColor,
                            readMoreAlign: Alignment.centerLeft,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Achievements',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10.0),
                          ReadMoreText(
                            provider.indDetailProfile.first.achievements,
                            numLines: 5,
                            readMoreText: 'Read more',
                            readLessText: 'Read less',
                            readMoreTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor),
                            readMoreIconColor: Theme.of(context).primaryColor,
                            readMoreAlign: Alignment.centerLeft,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildInfoItem(BuildContext context,
      {required String label, required String value}) {
    if (value.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black45, fontSize: 13.0)),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              flex: 2,
              child: Text(value,
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 13.0)),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
