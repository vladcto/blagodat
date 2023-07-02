import 'package:blagodat/presentation/constants/durations.dart';
import 'package:blagodat/presentation/constants/shadows.dart';
import 'package:flutter/material.dart';

/// Виджет, который может отображать счетчик, увеличивать и уменьшать его.
///
/// Если счетчик < 1, то он не отображается и виджет превращается в обычную
/// кнопку с надписью [zeroTitle].
class ChangeCounterButton extends StatelessWidget {
  static const double zeroTitleFontSize = 20;
  static const double counterFontSize = 20;
  static const fontWeight = FontWeight.w500;
  static const double counterYAnimation = -0.3;

  /// Заголовок, который отображается на кнопке, если [counter] == 0.
  final String zeroTitle;

  /// Значение, отображаемое на счетчике.
  final int counter;

  /// Вызывается при нажатие на кнопку или при нажатие на инкремент.
  final void Function() increase;

  /// Отступ кнопки при ненулевом значении счетчика.
  final double paddingNonZero;

  /// Вызывается при нажатии на кнопку декремента.
  final void Function() decrase;
  const ChangeCounterButton({
    Key? key,
    required this.zeroTitle,
    required this.counter,
    required this.increase,
    required this.decrase,
    this.paddingNonZero = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Виджет, для отображения счетчтика.
    final counterChild = counter > 0
        // Круглый счетчик.
        ? Container(
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: colorScheme.surfaceVariant,
              shadows: const [Shadows.topDown],
            ),
            alignment: Alignment.center,
            child: Text(
              "$counter",
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: fontWeight,
                fontSize: counterFontSize,
              ),
            ),
          )
        // Иначе ничего не отображаем.
        : null;

    // Виджет для отображения элементов контроля на кнопке.
    final buttonChild = counter > 0
        ? _IcnrementButtons(
            increase: increase,
            decrase: decrase,
          )
        : Center(
            child: Text(
              zeroTitle,
              style: TextStyle(
                fontSize: zeroTitleFontSize,
                fontWeight: fontWeight,
                color: colorScheme.onPrimary,
              ),
            ),
          );

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        // Отображаем кнопку и элементы на ней.
        AnimatedPositioned(
          top: _buttonPadding,
          bottom: _buttonPadding,
          left: 0,
          right: 0,
          duration: Durations.standart,
          // Отображаем кнопку, и если [counter] = 0, то включаем её.
          child: GestureDetector(
            onTap: () => counter > 0 ? null : increase(),
            child: Container(
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: colorScheme.secondary,
                shadows: const [Shadows.topDown],
              ),
              child: AnimatedSwitcher(
                duration: Durations.standart,
                child: buttonChild,
              ),
            ),
          ),
        ),
        // Отображаем счетчик
        Positioned(
          child: AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
              // Появление сверху с постепенным появлением.
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0, counterYAnimation),
                    end: const Offset(0, 0),
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            duration: Durations.standart,
            child: counterChild,
          ),
        ),
      ],
    );
  }

  double get _buttonPadding => counter > 0 ? paddingNonZero : 0;
}

/// Ряд кнопок для уменьшения, а затем увелечения чего либо.
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
              onPressed: decrase,
              icon: const Icon(Icons.remove),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: increase,
              icon: const Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }
}
