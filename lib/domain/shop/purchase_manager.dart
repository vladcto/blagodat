import 'dart:async';
import 'package:blagodat/domain/cart/cart.dart';
import 'package:blagodat/domain/shop/transaction.dart';
import 'package:blagodat/domain/discount/discount_provider.dart';

/// Менеджер оформления покупок.
class PurchaseManager {
  final Cart _cart;
  final DiscountProvider _discountProvider;

  final StreamController<Transaction> _transactionStreamController =
      StreamController<Transaction>.broadcast();

  PurchaseManager(this._cart, this._discountProvider);

  /// Поток успешных покупок.
  Stream<Transaction> get transactionStream =>
      _transactionStreamController.stream;

  /// Покупает корзину пользователя, с помощью наличных [cash] и бонусами [bonus].
  ///
  /// Возвращает true если покупка успешная.
  bool purchase(double cash, double bonus) {
    if (_cart.isNotEmpty) return false;
    // Может ли пользоваетель позволить себе покупку.
    double totalCost = _cart.cost * _discountProvider.discount;
    if (cash + bonus < totalCost) return false;
    final transaction = Transaction(
      totalCost: totalCost,
      purchaseTime: DateTime.now(),
    );
    _transactionStreamController.add(transaction);
    _cart.clear();
    return true;
  }

  void dispose() {
    _transactionStreamController.close();
  }
}
