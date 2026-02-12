import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.bottomBarItem});

  final List<BottomNavigationBarItem> bottomBarItem;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: bottomBarItem,
    );
  }
}
