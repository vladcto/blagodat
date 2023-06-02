import 'dart:async';
import 'package:blagodat/domain/cart/cart.dart';
import 'package:blagodat/domain/shop/transaction.dart';

class PurchaseManager {
  final Cart _cart;

  final StreamController<Transaction> _transactionStreamController =
      StreamController<Transaction>.broadcast();

  PurchaseManager(this._cart);

  Stream<Transaction> get transactionStream =>
      _transactionStreamController.stream;

  void purchase() {
    if (_cart.isNotEmpty) {
      final transaction = Transaction(
        totalCost: _cart.cost,
        purchaseTime: DateTime.now(),
      );
      _transactionStreamController.add(transaction);
      _cart.clear();
    }
  }

  void dispose() {
    _transactionStreamController.close();
  }
}
