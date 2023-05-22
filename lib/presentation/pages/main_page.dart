import 'package:blagodat/presentation/pages/fragments/settings_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/floating_bottom_bar.dart';
import 'fragments/home_fragment.dart';
import 'fragments/loyalty_fragment.dart';

final _pageIndexProvider = StateProvider<int>((ref) => 0);

/// The page that is displayed when the application starts.
class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
        onSelected: (i) => ref.read(_pageIndexProvider.notifier).state = i,
        surfaceColor: Colors.black.withOpacity(0.7),
      ),
      body: IndexedStack(
        index: ref.watch(_pageIndexProvider),
        children: const [
          HomeFragment(),
          LoyaltyFragment(),
          SettingsFragment(),
        ],
      ),
    );
  }
}
