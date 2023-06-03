import 'dart:async';
import 'dart:math';
import 'package:blagodat/domain/cart/cart.dart';
import 'package:blagodat/domain/discount/bonus_provider.dart';
import 'package:blagodat/domain/shop/transaction.dart';
import 'package:blagodat/domain/discount/discount_provider.dart';

/// Менеджер оформления покупок.
class PurchaseManager {
  final Cart _cart;
  final DiscountProvider _discountProvider;
  final BonusProvider bonusProvider;

  final StreamController<Transaction> _transactionStreamController =
      StreamController<Transaction>.broadcast();

  PurchaseManager(this._cart, this._discountProvider, this.bonusProvider);

  /// Поток успешных покупок.
  Stream<Transaction> get transactionStream =>
      _transactionStreamController.stream;

  /// Покупает корзину пользователя, с помощью наличных [cash] и бонусами [bonus].
  ///
  /// Возвращает true если покупка успешная.
  bool purchase(double cash, int bonus) {
    if (!_cart.isNotEmpty) return false;
    // Может ли пользоваетель позволить себе покупку.
    double totalCost = _cart.cost * _discountProvider.discount;
    bonus = min(totalCost.toInt(), bonus);
    if (cash + bonus < totalCost) return false;
    final transaction = Transaction(
      totalCost: totalCost,
      purchaseTime: DateTime.now(),
    );
    _transactionStreamController.add(transaction);
    bonusProvider.performTransaction(transaction);
    bonusProvider.spendBonus(bonus);
    _cart.clear();
    return true;
  }

  void dispose() {
    _transactionStreamController.close();
  }
}
