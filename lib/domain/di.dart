import 'package:blagodat/data/shop/assortment/assortment.dart';
import 'package:blagodat/data/shop/assortment/mock_assortment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final assortmentProvider = Provider<Assortment>((ref) => MockAssortment());
