import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../common/widgets/custom_scaffold/custom_scaffold.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBar: CustomAppBar(title: 'Shop'),
      body: Center(child: Text('Shop')),
    );
  }
}
