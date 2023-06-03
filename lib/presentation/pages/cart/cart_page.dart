import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/font_sizes.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/pages/cart/mock_card_payment.dart';
import 'package:blagodat/presentation/theme/app_colors.dart';
import 'package:blagodat/presentation/widgets/product_in_cart_card.dart';
import 'package:blagodat/presentation/widgets/row_end_start.dart';
import 'package:blagodat/presentation/widgets/sub_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  static const String title = "Корзина";

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(cartProvider).keys;

    final cartChilds = products
        .map(
          (e) => SizedBox(
            height: 120,
            child: ProductInCartCard(product: e),
          ),
        )
        .toList();

    return SubPage(
      title: title,
      trailing: TextButton(
        onPressed: () => ref.read(cartProvider.notifier).clear(),
        child: const Text(
          "clear",
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: FontSize.small,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
              left: Paddings.medium,
              right: Paddings.medium,
              top: Paddings.medium,
              bottom: 320,
            ),
            children: cartChilds,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 300,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Paddings.medium),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const _CartCostContainer(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartCostContainer extends ConsumerWidget {
  const _CartCostContainer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartProvider);
    final cost = ref.watch(cartProvider.notifier).cost;
    final discountCost = (1 - ref.watch(discountProvider).discount) * cost;
    final total = ref.watch(discountProvider).discount * cost;

    return Column(
      children: [
        const SizedBox(height: Paddings.large),
        Expanded(
          child: RowEndStart(
            start: const _BoldText("Цена:"),
            end: _BoldText("\$ ${cost.toStringAsFixed(2)}"),
          ),
        ),
        Expanded(
          child: RowEndStart(
            start: const _BoldText("Скидка:"),
            end: _BoldText(
              "-\$ ${discountCost.toStringAsFixed(2)}",
              color: Colors.green,
            ),
          ),
        ),
        const Placeholder(fallbackHeight: 8),
        Expanded(
          child: RowEndStart(
            start: const _BoldText(
              "Итого:",
              fontSize: 24,
            ),
            end: _BoldText(
              "\$ ${total.toStringAsFixed(2)}",
              fontSize: 24,
              color: Colors.green,
            ),
          ),
        ),
        // Трата бонусов.
        Expanded(
          child: Row(
            children: [
              _BoldText("Потратить: "),
              Expanded(
                child: _BonusField(),
              ),
              _BoldText("бонус из ${ref.watch(bonusProvider).bonus} бонусов.")
            ],
          ),
        ),
        const SizedBox(height: Paddings.medium),
        ElevatedButton(
          onPressed: () => showCartPayment(context),
          child: Placeholder(
            fallbackHeight: 60,
          ),
        ),
        const SizedBox(height: Paddings.large),
      ],
    );
  }

  void showCartPayment(BuildContext context) {
    showDialog(
        context: context, builder: (_) => MockCardPayment(onPayment: (_) {}));
  }
}

final _chooseBonus = StateProvider<int>((ref) => 0);

class _BonusField extends ConsumerStatefulWidget {
  const _BonusField({super.key});

  @override
  ConsumerState<_BonusField> createState() => __BonusFieldState();
}

class __BonusFieldState extends ConsumerState<_BonusField> {
  final bonusFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bonusFieldController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
      onSubmitted: (text) {
        int bonuses = ref.read(bonusProvider).bonus;
        int value = int.parse(text);
        if (value > bonuses) value = bonuses;
        bonusFieldController.text = bonuses.toString();
        ref.read(_chooseBonus.notifier).state = value;
      },
    );
  }

  @override
  void dispose() {
    bonusFieldController.dispose();
    super.dispose();
  }
}

class _BoldText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;

  const _BoldText(this.text, {this.fontSize = 17, this.color});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      style: TextStyle(
        color: color ?? colorScheme.onPrimary,
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
