import 'package:blagodat/data/shop/transaction.dart';
import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/pages/main_page.dart';
import 'package:blagodat/presentation/widgets/brand_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsFragment extends ConsumerWidget {
  static const headerText = BrandedTextWithColor("История", " покупок");

  const SettingsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionChilds = ref
        .watch(historyProvider)
        .map(
          (e) => _TransactionCard(e),
        )
        .toList();
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            child: BrandHeader(
              brandedText: headerText,
            ),
          ),
          Expanded(
            child: ListView(
              children: transactionChilds,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const _TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(transaction.purchaseTime.toString()),
        Text("    Итого: ${transaction.totalCost.toStringAsFixed(2)} \$"),
      ],
    );
  }
}
