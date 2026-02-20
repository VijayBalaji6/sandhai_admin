part of 'shop_bloc.dart';

sealed class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

final class ShopFetchRequested extends ShopEvent {
  const ShopFetchRequested({this.shopId});

  final String? shopId;

  @override
  List<Object?> get props => [shopId];
}

final class ShopProfileUpdated extends ShopEvent {
  const ShopProfileUpdated({
    required this.shopName,
    required this.shopDescription,
    required this.phone,
    required this.email,
    required this.address,
  });

  final String shopName;
  final String? shopDescription;
  final String phone;
  final String? email;
  final String? address;

  @override
  List<Object?> get props => [shopName, shopDescription, phone, email, address];
}

final class ShopWorkingHoursUpdated extends ShopEvent {
  const ShopWorkingHoursUpdated({
    required this.openingTime,
    required this.closingTime,
  });

  final String openingTime;
  final String closingTime;

  @override
  List<Object> get props => [openingTime, closingTime];
}

final class ShopActiveToggled extends ShopEvent {
  const ShopActiveToggled(this.isActive);

  final bool isActive;

  @override
  List<Object> get props => [isActive];
}

final class ShopAcceptsOrdersToggled extends ShopEvent {
  const ShopAcceptsOrdersToggled(this.acceptsOrders);

  final bool acceptsOrders;

  @override
  List<Object> get props => [acceptsOrders];
}

final class ShopPincodeAdded extends ShopEvent {
  const ShopPincodeAdded(this.pincode);

  final String pincode;

  @override
  List<Object> get props => [pincode];
}

final class ShopPincodeRemoved extends ShopEvent {
  const ShopPincodeRemoved(this.pincode);

  final String pincode;

  @override
  List<Object> get props => [pincode];
}

final class ShopMessageCleared extends ShopEvent {
  const ShopMessageCleared();
}
