import 'package:flutter/material.dart';

class NavItem {
  const NavItem(this.icon, this.selectedIcon, this.label);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

const List<NavItem> navItems = <NavItem>[
  NavItem(
    Icons.local_grocery_store_outlined,
    Icons.local_grocery_store,
    'Products',
  ),
  NavItem(Icons.receipt_long_outlined, Icons.receipt_long, 'Orders'),
  NavItem(Icons.history_outlined, Icons.history, 'History'),
  NavItem(Icons.storefront_outlined, Icons.storefront, 'Shop'),
  NavItem(Icons.people_outline, Icons.people, 'Users'),
  NavItem(Icons.people_outline, Icons.people, 'Settings'),
  NavItem(Icons.people_outline, Icons.people, 'Reports'),
];
