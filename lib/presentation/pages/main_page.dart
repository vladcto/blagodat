import 'package:blagodat/presentation/constants/paddings.dart';
import 'package:blagodat/presentation/pages/fragments/history_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/floating_bottom_bar.dart';
import 'home/home_fragment.dart';
import 'fragments/loyalty_fragment.dart';

final _pageIndexProvider = StateProvider<int>((ref) => 0);

/// The page that is displayed when the application starts.
class MainPage extends ConsumerWidget {
  /// Bottom padding included floating bar.
  static const double pageBarPadding =
      barHeight + barElevation + Paddings.medium;
  static const double barHeight = 76;
  static const double barElevation = 22;
  static const double barSideMargin = 64;
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: FloatingBottomBar(
        activeColor: Colors.yellow,
        inactiveColor: Colors.white,
        icons: const [
          Icons.home,
          Icons.loyalty,
          Icons.history,
        ],
        margin: const EdgeInsets.only(
          left: barSideMargin,
          right: barSideMargin,
          bottom: barElevation,
        ),
        height: barHeight,
        maxWidth: 500,
        onSelected: (i) => ref.read(_pageIndexProvider.notifier).state = i,
        surfaceColor: Colors.black.withOpacity(0.7),
      ),
      body: IndexedStack(
        index: ref.watch(_pageIndexProvider),
        children: const [
          HomeFragment(),
          LoyaltyFragment(),
          HistoryFragment(),
        ],
      ),
    );
  }
}
