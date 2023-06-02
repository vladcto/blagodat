import 'package:blagodat/presentation/constants/durations.dart';
import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Виджет, который может отображать счетчик, увеличивать и уменьшать его.
///
/// Если счетчик < 1, то он не отображается и виджет превращается в обычную
/// кнопку с надписью [zeroTitle].
class ChangeCounterButton extends StatelessWidget {
  static const double paddingNonZero = Paddings.medium;

  /// Заголовок, который отображается на кнопке, если [counter] == 0.
  final String zeroTitle;

  /// Значение, отображаемое на счетчике.
  final int counter;

  /// Вызывается при нажатие на кнопку или при нажатие на инкремент.
  final void Function() increase;

  /// Вызывается при нажатии на кнопку декремента.
  final void Function() decrase;
  const ChangeCounterButton(
      {Key? key,
      required this.zeroTitle,
      required this.counter,
      required this.increase,
      required this.decrase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final counterChild = counter > 0
        ? AspectRatio(
            aspectRatio: 1,
            child: CircleAvatar(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.mainOrange,
              child: Center(child: Text("$counter")),
            ),
          )
        : const SizedBox.shrink();

    final buttonChild = counter > 0
        ? _IcnrementButtons(
            increase: increase,
            decrase: decrase,
          )
        : const Center(child: Text("Some text"));

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        AnimatedPositioned(
          top: _buttonPadding,
          bottom: _buttonPadding,
          left: 0,
          right: 0,
          duration: Durations.standart,
          child: GestureDetector(
            onTap: () => counter > 0 ? null : increase(),
            child: Container(
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: colorScheme.primary,
              ),
              child: buttonChild,
            ),
          ),
        ),
        Positioned(child: counterChild),
      ],
    );
  }

  double get _buttonPadding => counter > 0 ? paddingNonZero : 0;
}

class _IcnrementButtons extends StatelessWidget {
  final void Function() increase;
  final void Function() decrase;

  const _IcnrementButtons({
    required this.increase,
    required this.decrase,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: increase,
              icon: const Icon(Icons.add),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: decrase,
              icon: const Icon(Icons.remove),
            ),
          ),
        )
      ],
    );
  }
}
