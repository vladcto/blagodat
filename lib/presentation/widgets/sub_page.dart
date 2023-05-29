import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Виджет, представляющий дополнительную страницу в стеке навигации.
///
/// Используется для страницы навигации и страницы корзины.
class SubPage extends StatelessWidget {
  static const double appBarHeight = 100;

  /// Название страницы, отображаемое по центру сверху.
  final String title;

  /// Виджет, отображаемый справа в заголовке.
  final Widget? trailing;

  /// Тело страницы.
  final Widget body;

  const SubPage(
      {Key? key, required this.title, this.trailing, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: Padding(
          padding: const EdgeInsets.all(Paddings.maximum),
          child: _SubPageAppBar(
            title: title,
            trailing: trailing,
          ),
        ),
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}

/// Заголовок [SubPage].
class _SubPageAppBar extends StatelessWidget {
  static const titleWeight = FontWeight.w700;

  /// Заглавие AppBar, отображаемое по центру.
  final String title;

  /// Виджет, находящийся полсе заглавия в AppBar.
  final Widget? trailing;

  // ignore: unused_element
  const _SubPageAppBar({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.mainTheme,
              ),
              // Переходим к предыдущему экрану.
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(Paddings.medium + 2),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: titleWeight,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: trailing ?? const SizedBox.shrink(),
        ),
      ],
    );
  }
}
