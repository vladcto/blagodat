import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

/// Вся информация о товаре в магазине.
@freezed
class Product with _$Product {
  @Assert('cost > 0')
  @Assert('name.isNotEmpty')
  @Assert('imageURL.length > 0')
  factory Product({
    /// Уникальный ID продукта.
    required String uid,

    /// Название продукта.
    required String name,

    /// Описание продукта.
    required String description,

    /// Веб-ссылки на изображение продукта.
    ///
    /// Должно быть хотя-бы одно изображение, которое будет являться основным.
    required List<String> imageURL,

    /// Цена продукта в долларах.
    required double cost,
  }) = _Product;
}
