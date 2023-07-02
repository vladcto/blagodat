import 'package:blagodat/data/shop/transaction.dart';
import 'package:blagodat/domain/di.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/widgets/brand_header.dart';
import 'package:blagodat/presentation/widgets/row_end_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryFragment extends ConsumerWidget {
  static const headerText = BrandedTextWithColor("История", " покупок");

  const HistoryFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionChilds = ref
        .watch(historyProvider)
        .map(
          (e) => SizedBox(
            height: 60,
            child: _TransactionCard(e),
          ),
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
              padding: const EdgeInsets.only(
                left: Paddings.large,
                right: Paddings.large,
                top: Paddings.small,
              ),
              children: transactionChilds,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  static const textStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  final Transaction transaction;

  const _TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    String shortDate = "${transaction.purchaseTime.day}." +
        "${transaction.purchaseTime.month}." +
        "${transaction.purchaseTime.year}";
    return RowEndStart(
      start: Text("$shortDate", style: textStyle),
      end: Text(
        "\$ ${transaction.totalCost.toStringAsFixed(2)}",
        style: textStyle,
      ),
    );
  }
}
