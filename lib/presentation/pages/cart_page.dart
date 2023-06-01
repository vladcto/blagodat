import 'package:blagodat/presentation/widgets/sub_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  static const String title = "Корзина";

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SubPage(
      title: title,
      body: Placeholder(),
    );
  }
}
