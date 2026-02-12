import 'package:QuIDPe/src/common/widgets/custom_error/custom_error_widget.dart';
import 'package:QuIDPe/src/common/widgets/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.data,
    this.loadingWidget = const CustomLoader(),
    this.retryAction,
  });

  final AsyncValue<T>? asyncValue;
  final Widget Function(T data) data;
  final Widget loadingWidget;
  final void Function()? retryAction;

  @override
  Widget build(BuildContext context) {
    return asyncValue?.when(
          data: (T value) => value == null ? loadingWidget : data(value),
          loading: () => loadingWidget,
          error: (e, _) => CustomErrorWidget(
            message: 'Error: $e',
            onRetry: () {
              retryAction?.call();
            },
          ),
        ) ??
        const SizedBox.shrink();
  }
}
