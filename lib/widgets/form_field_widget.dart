import 'package:digitalksp/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedFormField extends StatelessWidget {
  const RoundedFormField({
    super.key,
    required this.controller,
    required this.node,
    this.autofillHints,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.capitalization = TextCapitalization.none,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.autovalidateMode,
    this.obscureText = false,
    this.label,
    this.enabled = true,
    this.textInputAction = TextInputAction.none,
    this.readOnly = false,
    this.inputFormatters,
    this.borderRadius,
    this.fillColor,
    this.borderSide = BorderSide.none,
  });

  final TextEditingController controller;
  final FocusNode node;
  final Iterable<String>? autofillHints;
  final TextInputType keyboardType;
  final String? label;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextCapitalization capitalization;
  final String? Function(String? value)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final AutovalidateMode? autovalidateMode;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        label == null
            ? const SizedBox()
            : Text(label ?? '', style: Theme.of(context).textTheme.labelSmall),
        SizedBox(height: label == null ? 0.0 : 8.0),
        TextFormField(
          controller: controller,
          focusNode: node,
          autovalidateMode: autovalidateMode,
          keyboardType: keyboardType,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          clipBehavior: Clip.hardEdge,
          obscureText: obscureText,
          enabled: enabled,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: fillColor ?? Colors.grey.shade100,
            filled: true,
            counterText: '',

            // suffixIconConstraints:
            //     const BoxConstraints(minHeight: 40.0, minWidth: 40.0),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: borderRadius ??
                    BorderRadius.circular(AppDimensions.borderRadius)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: borderRadius ??
                    BorderRadius.circular(AppDimensions.borderRadius)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: borderRadius ??
                    BorderRadius.circular(AppDimensions.borderRadius)),
            hintStyle: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.grey.shade500),
          ),
          validator: validator,
          onTap: onTap,
          onChanged: onChanged,
          textInputAction: textInputAction,
          textCapitalization: capitalization,
          autofillHints: autofillHints,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
