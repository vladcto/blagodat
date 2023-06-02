import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/font_sizes.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/widgets/product_in_cart_card.dart';
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
            padding: const EdgeInsets.all(Paddings.medium),
            children: cartChilds,
          ),
        ],
      ),
    );
  }
}
