import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  const DashboardState({
    required this.shopName,
    required this.loading,
  });

  const DashboardState.initial()
      : shopName = 'Fruits & Veg Shop',
        loading = true;

  final String shopName;
  final bool loading;

  DashboardState copyWith({
    String? shopName,
    bool? loading,
  }) {
    return DashboardState(
      shopName: shopName ?? this.shopName,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [shopName, loading];
}

