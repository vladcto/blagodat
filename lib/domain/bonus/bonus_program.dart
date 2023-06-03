import 'package:blagodat/domain/bonus/discount_provider.dart';

class BonusProgram implements DiscountProvider {
  @override
  double get discount => 0.6;
}
