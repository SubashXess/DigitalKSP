import 'package:digitalksp/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.count,
    this.iconSize = 24.0,
  });

  final String icon;
  final VoidCallback onTap;
  final String? count;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.0,
        height: 44.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          border: Border.all(color: Colors.grey.shade200),
          color: Colors.transparent,
        ),
        child: Badge.count(
          isLabelVisible: count == null ? false : true,
          count: int.parse(count ?? '0'),
          child: SvgPicture.asset(
            icon,
            width: iconSize,
            height: iconSize,
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.height = AppDimensions.buttonHeight,
    this.backgroundColor,
    required this.label,
    required this.onTap,
  });

  final double height;
  final Color? backgroundColor;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          color: backgroundColor ?? Theme.of(context).primaryColor,
        ),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class SmallTextButton extends StatelessWidget {
  const SmallTextButton(
      {super.key, required this.label, this.labelColor, this.onTap});

  final String label;
  final Color? labelColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 12.0,
                color: labelColor ?? Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
