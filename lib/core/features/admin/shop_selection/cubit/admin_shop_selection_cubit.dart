import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../network/core/supabase_client.dart';
import '../../../../network/dtos/shop_model.dart';
import '../../../../network/repository/admin_shops_repository.dart';

enum AdminShopLoadStatus { initial, loading, loaded, failure }

class AdminShopSelectionState extends Equatable {
  const AdminShopSelectionState({
    this.status = AdminShopLoadStatus.initial,
    this.shops = const [],
    this.selectedShopId,
    this.errorMessage,
  });

  final AdminShopLoadStatus status;
  final List<ShopModel> shops;
  final String? selectedShopId;
  final String? errorMessage;

  bool get canSwitchShops => shops.length > 1;

  ShopModel? get selectedShop {
    final String? id = selectedShopId;
    if (id == null || shops.isEmpty) {
      return null;
    }
    for (final ShopModel s in shops) {
      if (s.id == id) {
        return s;
      }
    }
    return shops.first;
  }

  AdminShopSelectionState copyWith({
    AdminShopLoadStatus? status,
    List<ShopModel>? shops,
    String? selectedShopId,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AdminShopSelectionState(
      status: status ?? this.status,
      shops: shops ?? this.shops,
      selectedShopId: selectedShopId ?? this.selectedShopId,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, shops, selectedShopId, errorMessage];
}

class AdminShopSelectionCubit extends Cubit<AdminShopSelectionState> {
  AdminShopSelectionCubit({AdminShopsRepository? repository})
    : _repository = repository ?? AdminShopsRepository(),
      super(const AdminShopSelectionState());

  final AdminShopsRepository _repository;

  Future<void> load() async {
    if (!SupabaseClientProvider.isInitialized) {
      emit(
        state.copyWith(
          status: AdminShopLoadStatus.failure,
          errorMessage: 'Supabase is not configured.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AdminShopLoadStatus.loading,
        clearError: true,
      ),
    );

    final result = await _repository.loadAccessibleShops();
    result.when(
      success: (List<ShopModel> shops) {
        if (shops.isEmpty) {
          emit(
            state.copyWith(
              status: AdminShopLoadStatus.failure,
              shops: const [],
              selectedShopId: null,
              errorMessage: 'No shops available for this account.',
            ),
          );
          return;
        }

        final String? previousId = state.selectedShopId;
        final String nextId =
            previousId != null && shops.any((ShopModel s) => s.id == previousId)
            ? previousId
            : shops.first.id;

        emit(
          AdminShopSelectionState(
            status: AdminShopLoadStatus.loaded,
            shops: shops,
            selectedShopId: nextId,
          ),
        );
      },
      failure: (exception) {
        emit(
          state.copyWith(
            status: AdminShopLoadStatus.failure,
            errorMessage: exception.message,
          ),
        );
      },
    );
  }

  void selectShop(String shopId) {
    if (!state.canSwitchShops) {
      return;
    }
    if (!state.shops.any((ShopModel s) => s.id == shopId)) {
      return;
    }
    if (state.selectedShopId == shopId) {
      return;
    }
    emit(state.copyWith(selectedShopId: shopId));
  }
}
