import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/core/network/dtos/shop_model.dart';

import '../../../../network/core/api_result.dart';
import '../../../../network/dtos/shop_model.dart';
import '../../../../network/repository/shop_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc({ShopRepository? repository})
    : _repository = repository ?? ShopRepository(),
      super(const ShopState()) {
    on<ShopFetchRequested>(_onFetchRequested);
    on<ShopProfileUpdated>(_onProfileUpdated);
    on<ShopWorkingHoursUpdated>(_onWorkingHoursUpdated);
    on<ShopActiveToggled>(_onActiveToggled);
    on<ShopAcceptsOrdersToggled>(_onAcceptsOrdersToggled);
    on<ShopPincodeAdded>(_onPincodeAdded);
    on<ShopPincodeRemoved>(_onPincodeRemoved);
    on<ShopMessageCleared>(_onMessageCleared);
  }

  final ShopRepository _repository;

  Future<void> _onFetchRequested(
    ShopFetchRequested event,
    Emitter<ShopState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ShopStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final ApiResult<ShopModel> result = await _repository.fetchShop(
      id: event.shopId,
    );

    result.when(
      success: (ShopModel shop) {
        emit(
          state.copyWith(
            status: ShopStatus.loaded,
            shop: shop,
            clearError: true,
            clearSuccess: true,
          ),
        );
      },
      failure: (ApiException exception) {
        emit(
          state.copyWith(
            status: ShopStatus.failure,
            errorMessage: exception.message,
            clearSuccess: true,
          ),
        );
      },
    );
  }

  Future<void> _onProfileUpdated(
    ShopProfileUpdated event,
    Emitter<ShopState> emit,
  ) async {
    final ShopModel? currentShop = state.shop;
    if (currentShop == null) return;

    final ShopModel updatedShop = currentShop.copyWith(
      shopName: event.shopName.trim(),
      shopDescription: event.shopDescription?.trim().isEmpty ?? true
          ? null
          : event.shopDescription?.trim(),
      phone: event.phone.trim(),
      email: event.email?.trim().isEmpty ?? true ? null : event.email?.trim(),
      address: event.address?.trim().isEmpty ?? true
          ? null
          : event.address?.trim(),
    );

    await _persistShop(emit, updatedShop, successMessage: 'Shop details updated');
  }

  Future<void> _onWorkingHoursUpdated(
    ShopWorkingHoursUpdated event,
    Emitter<ShopState> emit,
  ) async {
    final ShopModel? currentShop = state.shop;
    if (currentShop == null) return;

    final ShopModel updatedShop = currentShop.copyWith(
      openingTime: event.openingTime.trim(),
      closingTime: event.closingTime.trim(),
    );

    await _persistShop(
      emit,
      updatedShop,
      successMessage: 'Working hours updated',
    );
  }

  Future<void> _onActiveToggled(
    ShopActiveToggled event,
    Emitter<ShopState> emit,
  ) async {
    final ShopModel? currentShop = state.shop;
    if (currentShop == null) return;

    final ShopModel updatedShop = currentShop.copyWith(isActive: event.isActive);
    await _persistShop(
      emit,
      updatedShop,
      successMessage: event.isActive
          ? 'Shop activated successfully'
          : 'Shop deactivated successfully',
    );
  }

  Future<void> _onAcceptsOrdersToggled(
    ShopAcceptsOrdersToggled event,
    Emitter<ShopState> emit,
  ) async {
    final ShopModel? currentShop = state.shop;
    if (currentShop == null) return;

    final ShopModel updatedShop = currentShop.copyWith(
      acceptsOrders: event.acceptsOrders,
    );

    await _persistShop(
      emit,
      updatedShop,
      successMessage: event.acceptsOrders
          ? 'Order acceptance enabled'
          : 'Order acceptance disabled',
    );
  }

  Future<void> _onPincodeAdded(
    ShopPincodeAdded event,
    Emitter<ShopState> emit,
  ) async {
    final ShopModel? currentShop = state.shop;
    if (currentShop == null) return;

    final String pincode = event.pincode.trim();
    if (pincode.isEmpty || currentShop.serviceablePinCodes.contains(pincode)) {
      return;
    }

    final ShopModel updatedShop = currentShop.copyWith(
      serviceablePincodes: <String>[
        ...currentShop.serviceablePinCodes,
        pincode,
      ],
    );

    await _persistShop(
      emit,
      updatedShop,
      successMessage: 'Pincode added successfully',
    );
  }

  Future<void> _onPincodeRemoved(
    ShopPincodeRemoved event,
    Emitter<ShopState> emit,
  ) async {
    final ShopModel? currentShop = state.shop;
    if (currentShop == null) return;

    final List<String> updatedPincodes = currentShop.serviceablePinCodes
        .where((String code) => code != event.pincode)
        .toList();

    final ShopModel updatedShop = currentShop.copyWith(
      serviceablePincodes: updatedPincodes,
    );

    await _persistShop(
      emit,
      updatedShop,
      successMessage: 'Pincode removed successfully',
    );
  }

  void _onMessageCleared(
    ShopMessageCleared event,
    Emitter<ShopState> emit,
  ) {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }

  Future<void> _persistShop(
    Emitter<ShopState> emit,
    ShopModel updatedShop, {
    required String successMessage,
  }) async {
    emit(
      state.copyWith(
        status: ShopStatus.updating,
        shop: updatedShop,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final ApiResult<ShopModel> result = await _repository.updateShop(updatedShop);

    result.when(
      success: (ShopModel shop) {
        emit(
          state.copyWith(
            status: ShopStatus.loaded,
            shop: shop,
            successMessage: successMessage,
            clearError: true,
          ),
        );
      },
      failure: (ApiException exception) {
        emit(
          state.copyWith(
            status: ShopStatus.failure,
            errorMessage: exception.message,
            clearSuccess: true,
          ),
        );
      },
    );
  }
}
