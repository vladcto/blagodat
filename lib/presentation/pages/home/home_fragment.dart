import 'package:blagodat/data/shop/info/product.dart';
import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/pages/cart_page.dart';
import 'package:blagodat/presentation/pages/home/product_home_preview_card.dart';
import 'package:blagodat/presentation/widgets/brand_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFragment extends StatelessWidget {
  static const headerText = BrandedTextWithColor("Благо", "Дать");
  static const double categoryHeaderSize = 38;

  /// Height that AppBar can expand.
  static const double expandedHeight = BrandHeader.kHeaderHeight + 25;

  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: expandedHeight,
          collapsedHeight: BrandHeader.kHeaderHeight,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            title: BrandHeader(
              brandedText: headerText,
              trailing: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CartPage(),
                  ),
                ),
                child: const Icon(Icons.abc),
              ),
            ),
          ),
        ),
        // TODO: Promo
        const SliverToBoxAdapter(
          child: Placeholder(fallbackHeight: 300),
        ),
        // TODO: Categories
        const SliverAppBar(
          pinned: true,
          // Disable expanding
          toolbarHeight: 1,
          collapsedHeight: categoryHeaderSize,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: Placeholder(
              color: Colors.orange,
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Paddings.medium),
          sliver: _ProductSliverList(),
        ),
      ],
    );
  }
}

/// Список товавров в магазине.
class _ProductSliverList extends ConsumerWidget {
  static const cardRatio = 156 / 225;

  const _ProductSliverList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(assortmentProvider).products;
    final productCards = [
      for (final product in products)
        // Центруем, чтобы поместить в ячейку [SliverGrid].
        Center(
          child: Padding(
            padding: const EdgeInsets.all(Paddings.small),
            child: ProductHomePreviewCard(product: product),
          ),
        ),
    ];

    // ? Может быть заменить на [SliverGrid.builder]
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: cardRatio,
      mainAxisSpacing: Paddings.small,
      children: productCards,
    );
  }
}
