import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/borders_radius.dart';
import 'package:blagodat/presentation/constants/font_sizes.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/pages/cart/cart_page.dart';
import 'package:blagodat/presentation/pages/home/product_home_preview_card.dart';
import 'package:blagodat/presentation/theme/app_colors.dart';
import 'package:blagodat/presentation/widgets/brand_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeFragment extends StatelessWidget {
  static const promoUrl =
      "https://www.crushpixel.com/big-static18/preview4/sale-banner-template-design-limited-2766676.jpg";
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
          backgroundColor: AppColors.white,
          surfaceTintColor: Colors.white,
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
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
        // TODO: Promo
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Paddings.medium),
            child: SizedBox(
              height: 240,
              child: ClipRRect(
                borderRadius: BordersRadius.standart,
                child: Image.network(
                  promoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // TODO: Categories
        const SliverAppBar(
          pinned: true,
          // Disable expanding
          toolbarHeight: 1,
          collapsedHeight: categoryHeaderSize,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              title: Center(
                child: Text(
                  "Продукты",
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )),
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
