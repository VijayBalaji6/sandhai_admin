import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [CircularProgressIndicator(), Text('Loading...')],
      ),
    );
  }
}
