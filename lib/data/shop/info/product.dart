import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  @Assert('cost > 0')
  @Assert('name.isNotEmpty')
  factory Product({
    /// Уникальный ID продукта.
    required String uid,

    /// Название продукта.
    required String name,

    /// Веб-ссылка на изображение продукта.
    required String imageURL,

    /// Цена продукта в долларах.
    required double cost,
  }) = _Product;
}
