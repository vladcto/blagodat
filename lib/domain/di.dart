import 'package:blagodat/data/shop/assortment/assortment.dart';
import 'package:blagodat/data/shop/assortment/mock_assortment.dart';
import 'package:blagodat/data/shop/info/product.dart';
import 'package:blagodat/domain/discount/bonus_program.dart';
import 'package:blagodat/domain/discount/bonus_provider.dart';
import 'package:blagodat/domain/discount/discount_provider.dart';
import 'package:blagodat/domain/cart/cart_state_notifier.dart';
import 'package:blagodat/domain/shop/purchase_manager.dart';
import 'package:blagodat/data/shop/transaction.dart';
import 'package:blagodat/domain/shop/transaction_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final assortmentProvider = Provider<Assortment>((ref) => MockAssortment());

final cartProvider =
    StateNotifierProvider<CartStateNotifier, Map<Product, int>>(
  (ref) => CartStateNotifier(),
);

final purchaseManager = Provider<PurchaseManager>(
  (ref) {
    final cart = ref.watch(cartProvider.notifier);
    final bonusProgram = ref.watch(bonusProvider);
    final discount = ref.watch(discountProvider);
    final manager = PurchaseManager(cart, discount, bonusProgram);
    return manager;
  },
);

final streamPurchaseProvider = Provider<Stream<Transaction>>(
  (ref) {
    return ref.watch(purchaseManager).transactionStream;
  },
);

final _bonusProgramProvider = Provider<BonusProgram>(
  (ref) => BonusProgram(),
);

final historyProvider =
    StateNotifierProvider<TransactionHistoryNotfier, List<Transaction>>(
  (ref) {
    final transactionHistory = TransactionHistoryNotfier();
    ref.read(streamPurchaseProvider).listen(
      (value) {
        transactionHistory.add(value);
      },
    );
    return transactionHistory;
  },
);

final Provider<DiscountProvider> discountProvider = _bonusProgramProvider;

final Provider<BonusProvider> bonusProvider = _bonusProgramProvider;
