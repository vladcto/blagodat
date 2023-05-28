import 'package:blagodat/presentation/widgets/header_text.dart';
import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  static const double headerSize = 100;
  static const double categoryHeaderSize = 38;

  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // TODO: Header
        const SliverAppBar(
          expandedHeight: headerSize,
          collapsedHeight: headerSize,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            title: BrandHeader(
              brandedText: BrandedTextWithColor("Благо", "Дать"),
              trailing: Icon(Icons.abc),
            ),
          ),
        ),
        // TODO: Promo
        SliverList(
          delegate: SliverChildListDelegate(
            [const Placeholder(fallbackHeight: 300)],
          ),
        ),
        // TODO: Categories
        const SliverAppBar(
          pinned: true,
          // Disable expanding
          toolbarHeight: 1,
          collapsedHeight: categoryHeaderSize,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: Placeholder(
              color: Colors.orange,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const Placeholder(fallbackHeight: 1000),
            ],
          ),
        )
      ],
    );
  }
}
