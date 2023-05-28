import 'package:blagodat/data/shop/info/product.dart';
import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
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
        const SliverAppBar(
          expandedHeight: expandedHeight,
          collapsedHeight: BrandHeader.kHeaderHeight,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            title: BrandHeader(
              brandedText: headerText,
              trailing: Icon(Icons.abc),
            ),
          ),
        ),
        // TODO: Promo
        // TODO: Заменить на [SliverToBoxAdapter]
        SliverList(
          delegate: SliverChildListDelegate(
            [const Placeholder(fallbackHeight: 300)],
          ),
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

class _ProductSliverList extends ConsumerWidget {
  static const cardHeight = 226.0;
  static const cardWidth = 156.0;

  const _ProductSliverList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(assortmentProvider).products[0];

    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: cardWidth / cardHeight,
      children: [
        Center(
          child: SizedBox(
            height: cardHeight,
            width: cardWidth,
            child: ProductHomePreviewCard(product: product),
          ),
        ),
      ],
    );
  }
}
