import 'package:blagodat/data/shop/info/product.dart';

abstract interface class Cart {
  void decrase(Product product);
  void add(Product product);
  void clear();
  double get cost;
  bool get isNotEmpty;
}
