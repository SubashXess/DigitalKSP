import 'dart:developer';

import 'package:digitalksp/widgets/buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future showEmptyState(
  BuildContext context, {
  required String icon,
  String header = 'Header',
  String subtitle = 'Subtitle',
  String buttonText = 'Label',
  required VoidCallback onPressed,
  VoidCallback? onCancelled,
}) {
  log('Now im here');

  return showModalBottomSheet(
    context: context,
    enableDrag: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isDismissible: false,
    builder: (context) => Stack(
      alignment: Alignment.topCenter,
      children: [
        SvgPicture.asset(
          icon,
          width: 240.0,
          height: 240.0,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.topRight,
          child: ActionButton(
            icon: 'assets/icons/close.svg',
            onTap: () => Navigator.pop(context),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(16.0 * 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                header,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10.0),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 24.0),
              RoundedButton(label: buttonText, onTap: onPressed),
            ],
          ),
        ),
      ],
    ),
  );
}
