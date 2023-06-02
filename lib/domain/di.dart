import 'package:blagodat/data/shop/assortment/assortment.dart';
import 'package:blagodat/data/shop/assortment/mock_assortment.dart';
import 'package:blagodat/data/shop/info/product.dart';
import 'package:blagodat/domain/cart/cart_state_notifier.dart';
import 'package:blagodat/domain/shop/purchase_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final assortmentProvider = Provider<Assortment>((ref) => MockAssortment());

final cartProvider =
    StateNotifierProvider<CartStateNotifier, Map<Product, int>>(
  (ref) => CartStateNotifier(),
);

final purchaseManager = Provider<PurchaseManager>(
  (ref) {
    final cart = ref.watch(cartProvider.notifier);
    final manager = PurchaseManager(cart);
    ref.onDispose(() => manager.dispose());
    return manager;
  },
);

final streamPurchaseProvider = StreamProvider(
  (ref) => ref.watch(purchaseManager).transactionStream,
);
