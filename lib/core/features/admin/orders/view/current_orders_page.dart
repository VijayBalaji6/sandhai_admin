import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../common/widgets/custom_scaffold/custom_scaffold.dart';

class CurrentOrdersPage extends StatelessWidget {
  const CurrentOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBar: CustomAppBar(title: 'Current Orders'),
      body: Center(child: Text('Current Orders')),
    );
  }
}
