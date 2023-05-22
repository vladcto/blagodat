import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // TODO: Header
        const SliverAppBar(
          expandedHeight: 200,
          collapsedHeight: 100,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1,
            titlePadding: EdgeInsets.zero,
            title: Placeholder(
              color: Colors.yellow,
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
          toolbarHeight: 1,
          collapsedHeight: 38,
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
