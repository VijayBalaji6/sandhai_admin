import '../core/api_result.dart';
import '../data_source/users_remote_data_source.dart';
import '../dtos/user_model.dart';

class UsersRepository {
  UsersRepository({UsersRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? UsersRemoteDataSource();

  final UsersRemoteDataSource _remoteDataSource;

  Future<ApiResult<List<UserModel>>> fetchUsers({
    String? orderBy,
    bool ascending = false,
    int? limit,
    int? offset,
  }) {
    return _remoteDataSource.fetchUsers(
      orderBy: orderBy,
      ascending: ascending,
      limit: limit,
      offset: offset,
    );
  }
}
