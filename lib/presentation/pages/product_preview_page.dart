import 'package:blagodat/data/shop/info/product.dart';
import 'package:blagodat/presentation/constants/font_sizes.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/widgets/sub_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Инднекс выбранного [product.imageUrl] для показа.
final _selectedImageIndex = StateProvider((ref) => 0);

/// Странца, отображающая информацию о товаре.
class ProductPreviewPage extends StatelessWidget {
  static const mainImageRatio = 360 / 290;

  final Product product;
  const ProductPreviewPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubPage(
      title: "Preview",
      body: Column(
        children: [
          // Main image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Paddings.medium),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: mainImageRatio,
                // Selected image in full size.
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
          const SizedBox(height: Paddings.medium),
          // Additional images
          SizedBox(
            height: 90,
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
                  ),
                ),
              ),
            ),
          ),
          // TODO: Controls
          const Placeholder(fallbackHeight: 88),
        ],
      ),
    );
  }
}

class _SmallImageCard extends StatelessWidget {
  final String imageUrl;
  final bool selected;

  const _SmallImageCard(this.imageUrl, this.selected);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? 1.05 : 0.95,
      duration: const Duration(milliseconds: 100),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
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
