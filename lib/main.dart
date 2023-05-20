import 'package:blagodat/presentation/widgets/floating_bottom_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        bottomNavigationBar: FloatingBottomBar(
          activeColor: Colors.yellow,
          inactiveColor: Colors.white,
          icons: const [
            Icons.abc,
            Icons.home,
            Icons.circle,
          ],
          maxWidth: 500,
          onSelected: (i) => print("Selected $i"),
          surfaceColor: Colors.black.withOpacity(0.7),
        ),
        body: const Placeholder(),
      ),
    );
  }
}
