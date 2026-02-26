import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../common/widgets/custom_scaffold/custom_scaffold.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBar: CustomAppBar(title: 'Products'),
      body: Center(child: Text('Products')),
    );
  }
}

