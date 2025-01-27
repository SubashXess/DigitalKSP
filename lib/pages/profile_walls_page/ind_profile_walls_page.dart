import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/wishwall_providers.dart';
import '../../utilities/utilities.dart';

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
                  onPressed: () async {
                    final provider = context.read<WishWallProviders>();

                    await Utilities.shareContent(
                      imageUrl: provider.indDetailProfile.first.profilePhoto,
                      text:
                          '${provider.indDetailProfile.first.fullName}\'s professional profile! Learn about their expertise and experiences.\n\nExplore more: https://digitalksp.com/ind-profile?id=${widget.profileId}',
                    );
                    // Utilities.shareIt(
                    //   context,
                    //   url:
                    //       'https://digitalksp.com/ind-profile?id=${widget.profileId}',
                    //   subject: provider.indDetailProfile.first.fullName,
                    //   text: 'Check out my profile on $APP_NAME',
                    // );
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/share-outlined.svg',
                    width: 20.0,
                    height: 20.0,
                  ),
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
                                    label: 'Highest Qualification',
                                    value: provider
                                        .indDetailProfile.first.qualification),
                                _buildInfoItem(context,
                                    label: 'Other Qualification',
                                    value: provider.indDetailProfile.first
                                        .otherQualification),
                                _buildInfoItem(
                                  context,
                                  label: 'Website',
                                  value: provider.indDetailProfile.first.url,
                                  onTap: () async {
                                    await Utilities.urlLauncher(
                                        url: provider
                                            .indDetailProfile.first.url);
                                  },
                                ),
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
                                _buildInfoItem(
                                  context,
                                  label: 'Mobile Number',
                                  value: provider.indDetailProfile.first.mobile,
                                  onTap: () async {
                                    RegExp phoneRegExp =
                                        RegExp(r'^\+?\d{10,14}$');
                                    if (phoneRegExp.hasMatch(provider
                                        .indDetailProfile.first.mobile)) {
                                      await Utilities.urlLauncher(
                                          url:
                                              'tel:${provider.indDetailProfile.first.mobile}');
                                    }
                                  },
                                ),
                                _buildInfoItem(
                                  context,
                                  label: 'Email Address',
                                  value: provider.indDetailProfile.first.email,
                                  onTap: () async {
                                    await Utilities.urlLauncher(
                                        url:
                                            'mailto:${provider.indDetailProfile.first.email}');
                                  },
                                ),
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
                          HtmlWidget(
                            provider.indDetailProfile.first.bio,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 13.0),
                          ),
                          // ReadMoreText(
                          //   provider.indDetailProfile.first.bio,
                          //   numLines: 5,
                          //   readMoreText: 'Read more',
                          //   readLessText: 'Read less',
                          //   readMoreTextStyle: Theme.of(context)
                          //       .textTheme
                          //       .bodyMedium
                          //       ?.copyWith(
                          //           color: Theme.of(context).primaryColor),
                          //   readMoreIconColor: Theme.of(context).primaryColor,
                          //   readMoreAlign: Alignment.centerLeft,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .bodyMedium
                          //       ?.copyWith(color: Colors.black54),
                          // ),
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
                          HtmlWidget(
                            provider.indDetailProfile.first.achievements,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 13.0),
                          ),
                          // ReadMoreText(
                          //   parse(provider.indDetailProfile.first.achievements)
                          //           .body
                          //           ?.text ??
                          //       '',
                          //   numLines: 5,
                          //   readMoreText: 'Read more',
                          //   readLessText: 'Read less',
                          //   readMoreTextStyle: Theme.of(context)
                          //       .textTheme
                          //       .bodyMedium
                          //       ?.copyWith(
                          //           color: Theme.of(context).primaryColor),
                          //   readMoreIconColor: Theme.of(context).primaryColor,
                          //   readMoreAlign: Alignment.centerLeft,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .bodyMedium
                          //       ?.copyWith(color: Colors.black54),
                          // ),
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
      {required String label, required String value, Function()? onTap}) {
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
            const SizedBox(width: 20.0, child: Text(':')),
            const SizedBox(width: 10.0),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTap,
                child: HtmlWidget(
                  value,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 13.0),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
