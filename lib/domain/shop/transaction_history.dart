import 'package:blagodat/data/shop/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHistoryNotfier extends StateNotifier<List<Transaction>> {
  TransactionHistoryNotfier() : super([]);

  void add(Transaction transaction) {
    state = [...state, transaction];
  }
}
