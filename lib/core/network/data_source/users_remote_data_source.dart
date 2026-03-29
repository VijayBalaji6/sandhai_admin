import '../core/api_result.dart';
import '../core/supabase_api.dart';
import '../dtos/user_address_model.dart';
import '../dtos/user_model.dart';

class UsersRemoteDataSource {
  final SupabaseApi _api = SupabaseApi('users');
  final SupabaseApi _addressesApi = SupabaseApi('addresses');

  Future<ApiResult<List<UserModel>>> fetchUsers({
    String? orderBy,
    bool ascending = false,
    int? limit,
    int? offset,
  }) {
    return _api.getAll<UserModel>(
      fromJson: UserModel.fromJson,
      columns: '*',
      orderBy: orderBy ?? 'created_at',
      ascending: ascending,
      limit: limit,
      offset: offset,
    );
  }

  Future<ApiResult<List<UserAddressModel>>> fetchAddressesByUserPhone(
    String userPhone,
  ) {
    final String phone = userPhone.trim();
    return _addressesApi.getByField<UserAddressModel>(
      field: 'user_phone',
      value: phone,
      fromJson: UserAddressModel.fromJson,
      orderBy: 'created_at',
      ascending: false,
    );
  }

  Future<ApiResult<UserAddressModel>> fetchAddressById(String addressId) {
    return _addressesApi.getById<UserAddressModel>(
      id: addressId,
      fromJson: UserAddressModel.fromJson,
    );
  }
}
