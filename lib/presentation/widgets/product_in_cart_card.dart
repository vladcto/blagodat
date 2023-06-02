import 'package:blagodat/data/shop/info/product.dart';
import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/borders_radius.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/widgets/change_counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductInCartCard extends StatelessWidget {
  final Product product;

  const ProductInCartCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AspectRatio(
          aspectRatio: 0.95,
          child: ClipRRect(
            borderRadius: BordersRadius.standart,
            child: Image.network(
              product.imageURL[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: Paddings.small),
            child: _InCartSideInfo(product),
          ),
        )
      ],
    );
  }
}

/// Информ
class _InCartSideInfo extends ConsumerWidget {
  final Product product;

  const _InCartSideInfo(this.product);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Product name.
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              product.name,
              maxLines: 2,
              style: const TextStyle(
                overflow: TextOverflow.visible,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        // Product control.
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "\$${product.cost}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: ChangeCounterButton(
                      zeroTitle: "Добавить",
                      counter: ref.watch(cartProvider)[product]!,
                      increase: () =>
                          ref.read(cartProvider.notifier).add(product),
                      decrase: () =>
                          ref.read(cartProvider.notifier).decrase(product),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
