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

  /// The blur of background of bottom bar.
  ///
  /// By default is set for 4.
  final double blur;

  const FloatingBottomBar({
    this.surfaceColor,
    this.shadows,
    this.padding = const EdgeInsets.all(8),
    this.blur = 4,
    required this.icons,
    required this.activeColor,
    required this.inactiveColor,
    Key? key,
  }) : super(key: key);

  @override
  State<FloatingBottomBar> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  @override
  Widget build(BuildContext context) {
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
                children: widget.icons
                    .map(
                      (item) => _BottomBarIconButton(
                        onTap: () {},
                        iconData: item,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBarIconButton extends StatelessWidget {
  static const double inkWellPadding = 4;

  final Function() onTap;
  final IconData iconData;
  const _BottomBarIconButton({required this.onTap, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(inkWellPadding),
          child: Icon(iconData),
        ),
      ),
    );
  }
}
