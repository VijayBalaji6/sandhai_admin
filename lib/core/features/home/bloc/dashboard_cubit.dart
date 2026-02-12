import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState.initial());

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    // TODO: Replace with real initial fetch (counts, pending orders, low stock).
    await Future<void>.delayed(const Duration(milliseconds: 250));
    emit(state.copyWith(loading: false));
  }
}

