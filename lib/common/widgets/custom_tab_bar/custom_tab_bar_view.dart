import 'package:flutter/material.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({
    super.key,
    required this.children,
    this.tabController,
  });

  final List<Widget> children;
  final TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: children,
      ),
    );
  }
}
