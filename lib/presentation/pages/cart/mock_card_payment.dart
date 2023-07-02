import 'package:blagodat/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _numProvider = StateProvider<double>((ref) => 0);

class MockCardPayment extends ConsumerWidget {
  final void Function(double) onPayment;

  const MockCardPayment({required this.onPayment, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      content: TextField(
        keyboardType: TextInputType.number,
        onChanged: (text) =>
            ref.read(_numProvider.notifier).state = double.parse(text),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onPayment(
              ref.read(_numProvider),
            );
            Navigator.of(context).pop();
          },
          child: const Text("Купить"),
        ),
      ],
    );
  }
}
