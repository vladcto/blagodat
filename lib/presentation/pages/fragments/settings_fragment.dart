import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/pages/main_page.dart';
import 'package:blagodat/presentation/widgets/brand_header.dart';
import 'package:flutter/material.dart';

class SettingsFragment extends StatelessWidget {
  static const headerText = BrandedTextWithColor("Set", "tings");

  const SettingsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          child: BrandHeader(
            brandedText: headerText,
          ),
        ),
        // TODO: Theme settings.
        Expanded(
          child: Center(
            child: Placeholder(
              child: SizedBox(
                width: 152,
                height: 165,
              ),
            ),
          ),
        ),
        // TODO: Credits btn.
        Padding(
          padding: EdgeInsets.all(Paddings.medium),
          child: Placeholder(
            fallbackHeight: 50,
          ),
        ),
        // Bottom bar space
        SizedBox(height: MainPage.pageBarPadding),
      ],
    );
  }
}
