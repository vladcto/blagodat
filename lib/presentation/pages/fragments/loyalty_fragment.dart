import 'package:blagodat/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';

/// Page fragment with the description of the loyalty program.
class LoyaltyFragment extends StatelessWidget {
  const LoyaltyFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // TODO: Header.
        SizedBox(
          height: 110,
          width: double.infinity,
          child: Placeholder(),
        ),
        // TODO: Info card.
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Placeholder(),
        ),
        // TODO: Levels info.
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Placeholder(),
        ),
        // TODO: Bonus count info.
        SizedBox(
          height: 120,
          child: Placeholder(),
        ),
        // Bottom bar space
        SizedBox(height: MainPage.pageBarPadding),
      ],
    );
  }
}
