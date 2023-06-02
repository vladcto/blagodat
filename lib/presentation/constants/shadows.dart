import 'package:flutter/material.dart';

sealed class Shadows {
  static const standart = BoxShadow(
    offset: Offset(4, 4),
    blurRadius: 6,
    color: Colors.black26,
  );

  static const topDown = BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 8,
    color: Colors.black26,
  );
}
