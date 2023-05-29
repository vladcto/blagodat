import 'package:flutter/material.dart';

sealed class Shadows {
  static const standart = BoxShadow(
    offset: Offset(4, 4),
    blurRadius: 6,
    color: Colors.black26,
  );
}
