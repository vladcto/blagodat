import 'dart:collection';

import 'package:blagodat/data/shop/info/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Определяет корзину покупок.
///
/// Хранит **неизменямый** словарь,
/// где *ключ* - [Product], а *значение* - его количество в корзине.
class Cart extends StateNotifier<Map<Product, int>> {
  final Map<Product, int> _cartMap;

  Cart()
      : _cartMap = {},
        super(UnmodifiableMapView({}));

  /// Добавить товар или увеличить его количество.
  ///
  /// Если товар **отсуствует** - делает его количество = 0.
  /// Если товар **присуствует** - прибавляет к его значению +1.
  void add(Product product) {
    _cartMap[product] = (_cartMap[product] ?? 0) + 1;
    state = UnmodifiableMapView(_cartMap);
  }

  /// Уменьшить или удалить товар.
  ///
  /// Если товара **больше 1** - уменьшает его количество на 1.
  /// Если товара **одна штука** - удаляет его из словаря.
  ///
  /// Если товар **отсутствует** - ничего не делает.
  void decrase(Product product) {
    // Cant decrase so skip.
    if (_cartMap[product] == null) return;

    final newValue = _cartMap[product]! - 1;
    // if need remove
    if (newValue == 0) {
      _cartMap.remove(product);
    } else {
      _cartMap[product] = newValue;
    }
    state = UnmodifiableMapView(_cartMap);
  }

  /// Полностью очищает словарь покупок.
  void clear() {
    _cartMap.clear();
    state = UnmodifiableMapView(_cartMap);
  }
}
