import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/borders_radius.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/constants/shadows.dart';
import 'package:blagodat/presentation/pages/main_page.dart';
import 'package:blagodat/presentation/theme/app_colors.dart';
import 'package:blagodat/presentation/widgets/brand_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page fragment with the description of the loyalty program.
class LoyaltyFragment extends StatelessWidget {
  static const headerText = BrandedTextWithColor(
    "Loyalty ",
    "Program",
  );

  const LoyaltyFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: double.infinity,
            child: BrandHeader(
              brandedText: headerText,
            ),
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
            child: _BonusCard(),
          ),
          // Bottom bar space
          SizedBox(height: MainPage.pageBarPadding),
        ],
      ),
    );
  }
}

class _BonusCard extends ConsumerWidget {
  const _BonusCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(streamPurchaseProvider);

    return Container(
      padding: const EdgeInsets.all(Paddings.small),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BordersRadius.standart,
        boxShadow: const [Shadows.topDown],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.breakfast_dining_sharp),
                  Container(
                    decoration: ShapeDecoration(
                      shape: StadiumBorder(),
                      color: AppColors.gold,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("132/250"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(ref.watch(bonusProvider).bonus.toString()),
          ),
        ],
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  final String text;

  const _FactRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          foregroundColor: AppColors.mainOrange,
        ),
        Text(text),
      ],
    );
  }
}
