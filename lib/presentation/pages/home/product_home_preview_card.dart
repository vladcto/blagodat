import 'package:blagodat/data/shop/info/product.dart';
import 'package:blagodat/presentation/constants/font_sizes.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/pages/product_preview_page.dart';
import 'package:flutter/material.dart';

/// Виджет, отображающий краткую информацию о продукте.
class ProductHomePreviewCard extends StatelessWidget {
  static const double imageBorderRadius = 16;

  final Product product;

  const ProductHomePreviewCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductPreviewPage(product: product),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(imageBorderRadius),
              child: Image.network(
                product.imageURL[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: Paddings.small / 2),
        Text(
          product.name,
          style: const TextStyle(
            fontSize: FontSize.small,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
          maxLines: 2,
        ),
        Text(
          "${product.cost.toStringAsFixed(2)}\$",
          style: const TextStyle(
            fontSize: FontSize.small,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
