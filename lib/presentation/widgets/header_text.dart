import 'package:blagodat/presentation/constants/font_sizes.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Widget that displays the page name as a branded header.
class BrandHeader extends StatelessWidget {
  static const double kHeaderHeight = 320;

  /// Header text with several color.
  final BrandedTextWithColor brandedText;

  /// Widget that shown in end of header.
  final Widget? trailing;

  const BrandHeader({Key? key, required this.brandedText, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Paddings.maximum,
          vertical: Paddings.small,
        ),
        child: SizedBox(
          height: kHeaderHeight,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _BrandHeaderText(brandedText),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: trailing ?? const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandHeaderText extends StatelessWidget {
  static const FontWeight prefixWeight = FontWeight.w400;
  static const FontWeight suffixWeight = FontWeight.w700;
  final BrandedTextWithColor brandedTextItemColor;

  const _BrandHeaderText(this.brandedTextItemColor);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: FontSize.header,
        ),
        children: [
          TextSpan(
            text: brandedTextItemColor.prefix,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: prefixWeight,
            ),
          ),
          TextSpan(
            text: brandedTextItemColor.suffix,
            style: const TextStyle(
              color: AppColors.mainTheme,
              fontWeight: suffixWeight,
            ),
          ),
        ],
      ),
    );
  }
}

/// Defines the text content with color scheme.
///
/// See also:
/// - [BrandHeader], a widget that creates a brand header app bar.
final class BrandedTextWithColor {
  /// Word that would be colored in black.
  final String prefix;

  /// Word that would be colored in yellow.
  final String suffix;

  const BrandedTextWithColor(this.prefix, this.suffix);
}
