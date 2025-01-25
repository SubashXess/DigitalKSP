import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/providers/wishwall_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../constants/styles.dart';
import '../../utilities/utilities.dart';

class OrgProfileWallPage extends StatefulWidget {
  const OrgProfileWallPage({super.key, required this.profileId});

  final String profileId;

  @override
  State<OrgProfileWallPage> createState() => _OrgProfileWallPageState();
}

class _OrgProfileWallPageState extends State<OrgProfileWallPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<WishWallProviders>()
        .getOrgDetailsProfile(id: widget.profileId);
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
                  onPressed: () {
                    final provider = context.read<WishWallProviders>();
                    Utilities.shareIt(
                      context,
                      url:
                          'https://digitalksp.com/org-profile?id=${widget.profileId}',
                      subject: provider.orgDetailProfile.first.orgName,
                      text: 'Check out our organization profile on $APP_NAME',
                    );
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
      body: Consumer<WishWallProviders>(
        builder: (context, provider, __) {
          return provider.orgDetailProfile.isEmpty
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
                                  provider.orgDetailProfile.first.profilePhoto),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              provider.orgDetailProfile.first.orgName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              provider.orgDetailProfile.first.industry,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
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
                                      label: 'Established Date',
                                      value: DateFormat('d MMM, yyyy').format(
                                          DateTime.parse(provider
                                              .orgDetailProfile
                                              .first
                                              .estDate))),
                                  _buildInfoItem(context,
                                      label: 'Years of Services',
                                      value: provider
                                          .orgDetailProfile.first.serviceYears),
                                  _buildInfoItem(context,
                                      label: 'Address',
                                      value: provider
                                          .orgDetailProfile.first.orgAddress),
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
                                    label: 'Phone Number',
                                    value: provider
                                        .orgDetailProfile.first.orgMobile,
                                    onTap: () async {
                                      RegExp phoneRegExp =
                                          RegExp(r'^\+?\d{10,14}$');
                                      if (phoneRegExp.hasMatch(provider
                                          .orgDetailProfile.first.orgMobile)) {
                                        await Utilities.urlLauncher(
                                            url:
                                                'tel:${provider.orgDetailProfile.first.orgMobile}');
                                      }
                                    },
                                  ),
                                  _buildInfoItem(
                                    context,
                                    label: 'Email Address',
                                    value: provider
                                        .orgDetailProfile.first.orgEmail,
                                    onTap: () async {
                                      await Utilities.urlLauncher(
                                          url:
                                              'mailto:${provider.orgDetailProfile.first.orgEmail}');
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
                              provider.orgDetailProfile.first.bio,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 13.0),
                            ),
                            // ReadMoreText(
                            //   provider.orgDetailProfile.first.bio,
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
                              provider.orgDetailProfile.first.achievements,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 13.0),
                            ),
                            // ReadMoreText(
                            //   provider.orgDetailProfile.first.achievements,
                            //   numLines: 5,
                            //   readMoreText: 'Read more',
                            //   readLessText: 'Read less',
                            //   readMoreTextStyle: Theme.of(context)
                            //       .textTheme
                            //       .labelLarge
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
                              'Other Information',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10.0),
                            HtmlWidget(
                              provider.orgDetailProfile.first.otherInformation,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 13.0),
                            ),
                            // ReadMoreText(
                            //   provider.orgDetailProfile.first.otherInformation,
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
        },
      ),
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
                child: Text(value,
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 13.0)),
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
