import 'package:blagodat/domain/discount/bonus_provider.dart';
import 'package:blagodat/domain/discount/discount_provider.dart';
import 'package:blagodat/domain/shop/transaction.dart';

class BonusProgram implements DiscountProvider, BonusProvider {
  int _bonus = 100;

  @override
  double get discount => 0.6;

  @override
  int get bonus => _bonus;

  /// Зарегестрировать транзакцию в бонусной программе.
  @override
  void performTransaction(Transaction transaction) {
    _bonus += (transaction.totalCost * 0.1).toInt();
  }

  /// Вычитает из текущего пула бонусов [spendBonus].
  ///
  /// Если количество бонусов для траты больше,
  @override
  void spendBonus(int spendBonus) {
    print(_bonus);
    if (_bonus < spendBonus) {
      throw Exception(
          "Количество бонусов для траты больше, чем бонусов в пуле.");
    }
    _bonus -= spendBonus;
  }
}
