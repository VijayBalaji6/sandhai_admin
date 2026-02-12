import 'package:flutter/material.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  const CustomRadioGroup(
      {super.key,
      required this.child,
      required this.groupValue,
      required this.onChanged});

  final Widget child;
  final T groupValue;
  final Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<T>(
      onChanged: (T? value) => onChanged(value),
      groupValue: groupValue,
      child: child,
    );
  }
}
