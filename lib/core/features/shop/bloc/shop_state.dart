part of 'shop_bloc.dart';

enum ShopStatus { initial, loading, loaded, updating, failure }

final class ShopState extends Equatable {
  const ShopState({
    this.status = ShopStatus.initial,
    this.shop,
    this.errorMessage,
    this.successMessage,
  });

  final ShopStatus status;
  final ShopModel? shop;
  final String? errorMessage;
  final String? successMessage;

  ShopState copyWith({
    ShopStatus? status,
    ShopModel? shop,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return ShopState(
      status: status ?? this.status,
      shop: shop ?? this.shop,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [status, shop, errorMessage, successMessage];
}
