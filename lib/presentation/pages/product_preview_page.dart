import 'package:blagodat/data/shop/info/product.dart';
import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/borders_radius.dart';
import 'package:blagodat/presentation/constants/durations.dart';
import 'package:blagodat/presentation/constants/font_sizes.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/constants/shadows.dart';
import 'package:blagodat/presentation/widgets/change_counter_button.dart';
import 'package:blagodat/presentation/widgets/sub_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Инднекс выбранного [product.imageUrl] для показа.
final _selectedImageIndex = StateProvider((ref) => 0);

/// Странца, отображающая информацию о товаре.
class ProductPreviewPage extends ConsumerWidget {
  static const String title = "Просмотр";
  static const mainImageRatio = 360 / 290;
  static const smallCardSize = 90.0;

  final Product product;
  const ProductPreviewPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartProvider)[product] ?? 0;

    return SubPage(
      title: title,
      body: Column(
        children: [
          // Main image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Paddings.medium),
            child: AspectRatio(
              aspectRatio: mainImageRatio,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BordersRadius.standart,
                  boxShadow: const [Shadows.standart],
                ),
                child: ClipRRect(
                  borderRadius: BordersRadius.standart,
                  child: Consumer(
                    builder: (_, ref, child) {
                      return Image.network(
                        product.imageURL[ref.watch(_selectedImageIndex)],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Paddings.medium),
          // Additional images
          SizedBox(
            height: smallCardSize,
            child: _ProductImageListView(product.imageURL),
          ),
          const SizedBox(height: Paddings.large),
          // Product name.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Paddings.medium),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.name,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: FontSize.large,
                ),
              ),
            ),
          ),
          // Product description.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Paddings.medium),
              child: SingleChildScrollView(
                child: Text(
                  product.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: FontSize.small,
                    height: 1.1,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: _ControlsRow(product),
          ),
        ],
      ),
    );
  }
}

class _SmallImageCard extends StatelessWidget {
  static const double minScale = 0.95;
  static const double maxScale = 1.05;
  final String imageUrl;
  final bool selected;

  const _SmallImageCard(this.imageUrl, this.selected);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? maxScale : minScale,
      duration: Durations.standart,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BordersRadius.standart,
            boxShadow: const [Shadows.standart],
          ),
          child: ClipRRect(
            borderRadius: BordersRadius.standart,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductImageListView extends ConsumerWidget {
  final List<String> imageUrl;
  const _ProductImageListView(this.imageUrl);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int selectedUrlIndex = ref.watch(_selectedImageIndex);
    final productChilds = [
      for (int i = 0; i < imageUrl.length; i++)
        GestureDetector(
          onTap: () => ref.read(_selectedImageIndex.notifier).state = i,
          child: _SmallImageCard(
            imageUrl[i],
            selectedUrlIndex == i,
          ),
        ),
    ];

    return ListView.builder(
      // Images and space btw them.
      itemCount: imageUrl.length * 2 - 1,
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(horizontal: Paddings.medium),
      // Create images card and space.
      itemBuilder: (_, i) => i % 2 == 0
          ? productChilds[i ~/ 2]
          : const SizedBox(width: Paddings.small),
    );
  }
}

/// Виджет, который отображает цену и кнопку добавления в корзину.
class _ControlsRow extends ConsumerWidget {
  final Product product;
  const _ControlsRow(this.product);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Paddings.medium,
        right: Paddings.medium,
        bottom: Paddings.large,
        top: Paddings.small / 2,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              // TODO: Вынести в константы и соотнести отсутп с [ChangeCounterButton].
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.topLeft,
                // TODO: Не хардкодить размер текста, а расширять его по мере.
                // TODO: Вынести жирность шрифта в константы.
                child: Text(
                  "\$ ${product.cost.toStringAsFixed(2)}",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: ChangeCounterButton(
                zeroTitle: "Добавить",
                counter: ref.watch(cartProvider)[product] ?? 0,
                increase: () => ref.watch(cartProvider.notifier).add(product),
                decrase: () =>
                    ref.watch(cartProvider.notifier).decrase(product),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
