import '../core/api_result.dart';
import '../core/supabase_api.dart';
import '../dtos/user_model.dart';

class UsersRemoteDataSource {
  final SupabaseApi _api = SupabaseApi('users');

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
}
