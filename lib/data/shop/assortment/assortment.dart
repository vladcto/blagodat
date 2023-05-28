import 'package:blagodat/data/shop/info/product.dart';

/// Интерфейс, предоставляющий получение списка товаров.
abstract interface class Assortment {
  /// Список товаров доступный в магазине.
  List<Product> get products;
}
