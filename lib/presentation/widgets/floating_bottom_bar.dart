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

  /// The margin of floating bar sides.
  ///
  /// By default is set for [EdgeInsets.all(8)].
  final EdgeInsets margin;

  /// Maximum width of floating bar container.
  ///
  /// By default is set for [double.maxFinite].
  final double maxWidth;

  /// Height of floating bar container.
  ///
  /// By default is set for 96.
  final double height;

  /// List of icons that displayed in bottom bar.
  final List<IconData> icons;

  /// Index of start selected icon from [icons].
  final int startItemIndex;

  /// The blur of background of bottom bar.
  ///
  /// By default is set for 4.
  final double blur;

  /// Alignment of bar.
  ///
  /// By defaul is set for [Alignment.bottomCenter]
  final Alignment alignment;

  /// Callback about switching the selected bar element to [selectedIndex].
  final Function(int selectedIndex) onSelected;

  const FloatingBottomBar({
    this.surfaceColor,
    this.shadows,
    this.margin = const EdgeInsets.only(left: 64, right: 64, bottom: 32),
    this.maxWidth = double.maxFinite,
    this.height = 96,
    this.blur = 4,
    this.startItemIndex = 0,
    this.alignment = Alignment.bottomCenter,
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
  static const double childPadding = 16;

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
      // Build active or inactive icon button.
      for (int i = 0; i < widget.icons.length; i++)
        Expanded(
          child: _BottomBarIconButton(
            onTap: () => _updateSelectedIndex(i),
            iconData: widget.icons[i],
            color: _nowSelectedIndex == i
                ? widget.activeColor
                : widget.inactiveColor,
            isEnabled: _nowSelectedIndex == i,
          ),
        )
    ];

    return Align(
      alignment: widget.alignment,
      child: Padding(
        padding: widget.margin,
        // Create blur effect.
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
            child: Material(
              color: widget.surfaceColor,
              // Content
              child: Container(
                constraints: BoxConstraints(maxWidth: widget.maxWidth),
                clipBehavior: Clip.hardEdge,
                height: widget.height,
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  shadows: widget.shadows,
                ),
                padding: const EdgeInsets.all(childPadding),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: iconButtons,
                ),
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
  static const scaleDuration = Duration(milliseconds: 100);
  static const maxScale = 1.0;
  static const minScale = 0.85;

  final Function() onTap;
  final IconData iconData;
  final Color color;

  /// Button is active or not.
  final bool isEnabled;

  const _BottomBarIconButton({
    required this.onTap,
    required this.iconData,
    required this.color,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: scaleDuration,
      scale: isEnabled ? maxScale : minScale,
      child: FittedBox(
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
      ),
    );
  }
}
