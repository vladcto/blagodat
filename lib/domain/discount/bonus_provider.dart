import 'package:blagodat/domain/shop/transaction.dart';

abstract interface class BonusProvider {
  int get bonus;
  void spendBonus(int spendBonus);
  void performTransaction(Transaction transaction);
}
