import 'package:flutter/material.dart';

import '../../../widgets/buttons_widget.dart';

class HeadlineSection extends StatelessWidget {
  const HeadlineSection(
      {super.key, required this.headline, this.showMore = false, this.onTap});

  final String headline;
  final bool showMore;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(headline,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16.0)),
          ),
          SizedBox(width: showMore ? 10.0 : 0.0),
          showMore
              ? SmallTextButton(
                  label: 'View all',
                  onTap: onTap,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
