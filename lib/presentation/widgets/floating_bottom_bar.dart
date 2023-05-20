import 'dart:ui';

import 'package:flutter/material.dart';

/// Navigation bar with stadium borders.
class FloatingBottomBar extends StatefulWidget {
  /// Background color of bottom bar.
  final Color? surfaceColor;

  /// Color for active icon button.
  final Color activeColor;

  /// Color for inactive icon button.
  final Color inactiveColor;

  /// Shadows from background of bottom bar.
  final List<BoxShadow>? shadows;

  /// The padding for childs.
  ///
  /// By default is set for [EdgeInsets.all(8)].
  final EdgeInsets padding;

  /// List of icons that displayed in bottom bar.
  final List<IconData> icons;

  /// Index of start selected icon from [icons].
  final int startItemIndex;

  /// The blur of background of bottom bar.
  ///
  /// By default is set for 4.
  final double blur;

  final Function(int selectedIndex) onSelected;

  const FloatingBottomBar({
    this.surfaceColor,
    this.shadows,
    this.padding = const EdgeInsets.all(8),
    this.blur = 4,
    this.startItemIndex = 0,
    required this.icons,
    required this.activeColor,
    required this.inactiveColor,
    required this.onSelected,
    Key? key,
  })  : assert(
          startItemIndex < icons.length,
          "Start item index shoud be contained in icons.",
        ),
        super(key: key);

  @override
  State<FloatingBottomBar> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  /// Selected index in [widget.icons].
  late int _nowSelectedIndex;

  @override
  void initState() {
    super.initState();
    _nowSelectedIndex = widget.startItemIndex;
  }

  @override
  Widget build(BuildContext context) {
    final iconButtons = [
      for (int i = 0; i < widget.icons.length; i++)
        _BottomBarIconButton(
          onTap: () => _updateSelectedIndex(i),
          iconData: widget.icons[i],
          color: _nowSelectedIndex == i
              ? widget.activeColor
              : widget.inactiveColor,
        )
    ];

    return Padding(
      padding: widget.padding,
      // Create blur effect.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: Material(
            color: widget.surfaceColor,
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: 128,
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                shadows: widget.shadows,
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: iconButtons,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Updates selected item.
  void _updateSelectedIndex(int selectedIndex) {
    if (_nowSelectedIndex == selectedIndex) return;
    setState(() {
      _nowSelectedIndex = selectedIndex;
    });
    widget.onSelected(_nowSelectedIndex);
  }
}

class _BottomBarIconButton extends StatelessWidget {
  static const double inkWellPadding = 4;

  final Function() onTap;
  final IconData iconData;
  final Color color;
  const _BottomBarIconButton({
    required this.onTap,
    required this.iconData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(inkWellPadding),
          child: Icon(
            iconData,
            color: color,
          ),
        ),
      ),
    );
  }
}
