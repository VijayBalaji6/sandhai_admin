import 'package:supabase_flutter/supabase_flutter.dart';

import 'api_handler.dart';
import 'api_result.dart';
import 'supabase_client.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class SupabaseApi {
  SupabaseApi(
    this._table, {
    this.timeout = const Duration(seconds: 30),
    this.checkConnection = true,
  });

  final String _table;
  final Duration timeout;
  final bool checkConnection;

  SupabaseQueryBuilder get _query => SupabaseClientProvider.client.from(_table);

  // ---------------------------------------------------------------------------
  // SELECT
  // ---------------------------------------------------------------------------



Future<ApiResult<List<T>>> getAll<T>({
  required FromJson<T> fromJson,
  String columns = '*',
  Map<String, dynamic>? filters,
  String? orderBy,
  bool ascending = true,
  int? limit,
  int? offset,
}) {
  final supabase = Supabase.instance.client;

  return ApiHandler.guard(
    tag: '$_table.getAll',
    action: () async {
      PostgrestFilterBuilder query =
          supabase.from(_table).select(columns);

      // Apply filters
      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      PostgrestTransformBuilder transform = query;

      if (orderBy != null) {
        transform = transform.order(orderBy, ascending: ascending);
      }

      if (limit != null) {
        transform = transform.limit(limit);
      }

      if (offset != null) {
        transform = transform.range(
          offset,
          offset + (limit ?? 20) - 1,
        );
      }

      /// 🔥 Supabase v2 returns List directly
      final List<dynamic> data =
          await transform as List<dynamic>;

      return data
          .cast<Map<String, dynamic>>()
          .map(fromJson)
          .toList();
    },
  );
}

  Future<ApiResult<T>> getById<T>({
    required String id,
    required FromJson<T> fromJson,
    String columns = '*',
  }) => ApiHandler.guard(
    tag: '$_table.getById',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      final data = await _query.select(columns).eq('id', id).single();
      return fromJson(data);
    },
  );

  Future<ApiResult<List<T>>> getByField<T>({
    required String field,
    required dynamic value,
    required FromJson<T> fromJson,
    String columns = '*',
    String? orderBy,
    bool ascending = true,
  }) => ApiHandler.guard(
    tag: '$_table.getByField($field)',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      PostgrestFilterBuilder query = _query.select(columns).eq(field, value);

      PostgrestTransformBuilder transform = query;
      if (orderBy != null) {
        transform = transform.order(orderBy, ascending: ascending);
      }

      final List<dynamic> data = await transform;
      return data.cast<Map<String, dynamic>>().map(fromJson).toList();
    },
  );

  // ---------------------------------------------------------------------------
  // INSERT
  // ---------------------------------------------------------------------------

  Future<ApiResult<T>> insert<T>({
    required Map<String, dynamic> data,
    required FromJson<T> fromJson,
  }) => ApiHandler.guard(
    tag: '$_table.insert',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      final result = await _query.insert(data).select().single();
      return fromJson(result);
    },
  );

  Future<ApiResult<List<T>>> insertMany<T>({
    required List<Map<String, dynamic>> rows,
    required FromJson<T> fromJson,
  }) => ApiHandler.guard(
    tag: '$_table.insertMany',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      final List<dynamic> result = await _query.insert(rows).select();
      return result.cast<Map<String, dynamic>>().map(fromJson).toList();
    },
  );

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<ApiResult<T>> update<T>({
    required String id,
    required Map<String, dynamic> data,
    required FromJson<T> fromJson,
  }) => ApiHandler.guard(
    tag: '$_table.update',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      final result = await _query.update(data).eq('id', id).select().single();
      return fromJson(result);
    },
  );

  // ---------------------------------------------------------------------------
  // UPSERT
  // ---------------------------------------------------------------------------

  Future<ApiResult<T>> upsert<T>({
    required Map<String, dynamic> data,
    required FromJson<T> fromJson,
  }) => ApiHandler.guard(
    tag: '$_table.upsert',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      final result = await _query.upsert(data).select().single();
      return fromJson(result);
    },
  );

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  Future<ApiResult<void>> delete({required String id}) => ApiHandler.guard(
    tag: '$_table.delete',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      await _query.delete().eq('id', id);
    },
  );

  Future<ApiResult<void>> deleteByField({
    required String field,
    required dynamic value,
  }) => ApiHandler.guard(
    tag: '$_table.deleteByField($field)',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      await _query.delete().eq(field, value);
    },
  );

  // ---------------------------------------------------------------------------
  // COUNT
  // ---------------------------------------------------------------------------

  Future<ApiResult<int>> count({Map<String, dynamic>? filters}) =>
      ApiHandler.guard(
        tag: '$_table.count',
        timeout: timeout,
        checkConnection: checkConnection,
        action: () async {
          PostgrestFilterBuilder query = _query.count(CountOption.exact);
          query = _applyFilters(query, filters);

          final int total = await query;
          return total;
        },
      );

  // ---------------------------------------------------------------------------
  // RPC (stored procedures / functions)
  // ---------------------------------------------------------------------------

  Future<ApiResult<T>> rpc<T>({
    required String functionName,
    Map<String, dynamic>? params,
    required T Function(dynamic response) parser,
  }) => ApiHandler.guard(
    tag: 'rpc:$functionName',
    timeout: timeout,
    checkConnection: checkConnection,
    action: () async {
      final result = await SupabaseClientProvider.client.rpc(
        functionName,
        params: params,
      );
      return parser(result);
    },
  );

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  PostgrestFilterBuilder _applyFilters(
    PostgrestFilterBuilder query,
    Map<String, dynamic>? filters,
  ) {
    if (filters == null) return query;
    for (final entry in filters.entries) {
      query = query.eq(entry.key, entry.value);
    }
    return query;
  }
}
