import 'package:flutter/material.dart';

class RowEndStart extends StatelessWidget {
  final Widget start;
  final Widget end;

  const RowEndStart({
    Key? key,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: start,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: end,
          ),
        ),
      ],
    );
  }
}
