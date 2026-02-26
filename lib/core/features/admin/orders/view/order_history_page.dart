import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../common/widgets/custom_scaffold/custom_scaffold.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBar: CustomAppBar(title: 'Order History'),
      body: Center(child: Text('Order History')),
    );
  }
}
