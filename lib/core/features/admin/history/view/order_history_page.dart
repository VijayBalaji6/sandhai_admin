import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/common/utils/date_time_utils.dart';
import 'package:sandhai_admin/common/utils/toast_utils.dart';
import 'package:sandhai_admin/core/features/admin/orders/bloc/orders_bloc.dart';
import 'package:sandhai_admin/core/network/core/api_result.dart';
import 'package:sandhai_admin/core/network/dtos/order_item_model.dart';
import 'package:sandhai_admin/core/network/dtos/order_model.dart';
import 'package:sandhai_admin/core/network/dtos/user_address_model.dart';
import 'package:sandhai_admin/core/network/repository/orders_repository.dart';
import 'package:sandhai_admin/core/network/repository/users_repository.dart';

import '../../../../../common/widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../common/widgets/custom_scaffold/custom_scaffold.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late final OrdersBloc _ordersBloc;
  late final OrdersRepository _ordersRepository;
  late final UsersRepository _usersRepository;
  Map<String, String> _userNamesByPhone = const {};
  Map<String, UserAddressModel> _addressesById = const {};

  @override
  void initState() {
    super.initState();
    _ordersBloc = OrdersBloc()
      ..add(
        const OrdersFetchRequested(
          filterMode: OrdersFilterMode.completedOnly,
        ),
      );
    _ordersRepository = OrdersRepository();
    _usersRepository = UsersRepository();
    _loadUserNames();
  }

  @override
  void dispose() {
    _ordersBloc.close();
    super.dispose();
  }

  Future<void> _loadUserNames() async {
    final result = await _usersRepository.fetchUsers();
    if (!mounted) return;
    result.when(
      success: (users) {
        final Map<String, String> names = <String, String>{};
        for (final user in users) {
          names[user.phone.trim()] = user.name.trim();
        }
        setState(() => _userNamesByPhone = names);
      },
      failure: (_) {},
    );
  }

  Future<void> _loadAddressesForOrders(List<OrderModel> orders) async {
    final Set<String> addressIds = orders
        .map((order) => order.addressId?.trim() ?? '')
        .where((id) => id.isNotEmpty)
        .toSet();
    if (addressIds.isEmpty) {
      if (_addressesById.isNotEmpty && mounted) {
        setState(() => _addressesById = const {});
      }
      return;
    }

    final Map<String, UserAddressModel> next = <String, UserAddressModel>{};
    for (final addressId in addressIds) {
      final result = await _usersRepository.fetchAddressById(addressId);
      result.when(
        success: (address) => next[addressId] = address,
        failure: (_) {},
      );
    }
    if (!mounted) return;
    setState(() => _addressesById = next);
  }

  void _refresh() {
    _ordersBloc.add(
      const OrdersFetchRequested(
        filterMode: OrdersFilterMode.completedOnly,
      ),
    );
    _loadUserNames();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersBloc>.value(
      value: _ordersBloc,
      child: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          _loadAddressesForOrders(state.orders);
          if (state.errorMessage != null) {
            ToastUtils.showErrorToast(state.errorMessage!);
            _ordersBloc.add(const OrdersMessageCleared());
          }
          if (state.successMessage != null) {
            ToastUtils.showSuccessToast(state.successMessage!);
            _ordersBloc.add(const OrdersMessageCleared());
          }
        },
        builder: (context, state) {
          return CustomScaffold(
            appBar: CustomAppBar(
              title: 'Order History',
              trailingWidget: [
                IconButton(
                  icon: state.status == OrdersStatus.loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh),
                  tooltip: 'Refresh',
                  onPressed:
                      state.status == OrdersStatus.loading ? null : _refresh,
                ),
              ],
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(OrdersState state) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    if (state.status == OrdersStatus.loading && state.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                child: _HistoryTabBar(scheme: scheme),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildHistoryTab(state, OrderStatusEnum.delivered),
                    _buildHistoryTab(state, OrderStatusEnum.cancelled),
                    _buildHistoryTab(state, OrderStatusEnum.undelivered),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (state.status == OrdersStatus.loading)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildHistoryTab(OrdersState state, OrderStatusEnum status) {
    final List<OrderModel> filtered = state.orders
        .where((OrderModel o) => o.status == status)
        .toList();

    return RefreshIndicator(
      onRefresh: () async {
        _refresh();
        await Future<void>.delayed(const Duration(milliseconds: 250));
      },
      child: filtered.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
                Center(child: Text(_emptyMessage(status))),
              ],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final order = filtered[index];
                final String? customerName =
                    _userNamesByPhone[order.userPhone.trim()];
                final UserAddressModel? address = order.addressId == null
                    ? null
                    : _addressesById[order.addressId!.trim()];
                return Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    title: Text(
                      'Order #${order.id.substring(0, 8)}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        if (order.createdAt != null)
                          Text(
                            DateTimeUtils.getFormattedDateTime(
                              dateTimeData: order.createdAt,
                              dateTimeFormat: DateFormatUtils.ddMMMYYhhmmA,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        if (order.createdAt != null) const SizedBox(height: 4),
                        if (customerName?.isNotEmpty == true)
                          Text(
                            customerName!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        if (customerName?.isNotEmpty == true)
                          const SizedBox(height: 4),
                        Text(_formattedDeliveryAddress(address), maxLines: 2),
                        const SizedBox(height: 4),
                        Text('Phone: ${order.userPhone}'),
                        const SizedBox(height: 4),
                        Text(
                          'Amount: ₹${order.totalAmount.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 132,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: _StatusChip(status: order.status)),
                          IconButton(
                            tooltip: 'Order details',
                            icon: const Icon(Icons.receipt_long_outlined),
                            onPressed: () => _showOrderDetailsPopup(
                              order,
                              customerName: customerName,
                              address: address,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _showOrderDetailsPopup(
    OrderModel order, {
    String? customerName,
    UserAddressModel? address,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order #${order.id.substring(0, 8)} Details'),
          content: SizedBox(
            width: 760,
            height: 470,
            child: FutureBuilder<ApiResult<List<OrderItemModel>>>(
              future: _ordersRepository.fetchOrderItems(order.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('Unable to load order items'));
                }

                return snapshot.data!.when(
                  success: (List<OrderItemModel> items) {
                    if (items.isEmpty) {
                      return const Center(child: Text('No order items found'));
                    }

                    final double itemsTotal = items.fold<double>(
                      0,
                      (sum, item) => sum + item.subtotal,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer: ${customerName?.isNotEmpty == true ? customerName : 'Unknown'}',
                        ),
                        const SizedBox(height: 4),
                        Text('Phone: ${order.userPhone}'),
                        const SizedBox(height: 4),
                        Text(
                          'Address: ${_formattedDeliveryAddress(address)}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.separated(
                              itemCount: items.length,
                              separatorBuilder: (_, __) => const Divider(height: 16),
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Product: ${item.productId.substring(0, 8)}\n'
                                        'Variant: ${item.variantId.substring(0, 8)}',
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${item.quantity.toStringAsFixed(2)} ${item.unitType.name}',
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '₹${item.price.toStringAsFixed(2)}',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '₹${item.subtotal.toStringAsFixed(2)}',
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const Divider(height: 18),
                        Row(
                          children: [
                            const Text(
                              'Items Total',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              '₹${itemsTotal.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text(
                              'Order Total',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Text(
                              '₹${order.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  failure: (exception) =>
                      Center(child: Text(exception.message)),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  static String _emptyMessage(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.delivered:
        return 'No delivered orders';
      case OrderStatusEnum.cancelled:
        return 'No cancelled orders';
      case OrderStatusEnum.undelivered:
        return 'No undelivered orders';
      default:
        return 'No orders';
    }
  }
}

String _formattedDeliveryAddress(UserAddressModel? addressModel) {
  if (addressModel == null) {
    return 'Address not available';
  }
  final String address = addressModel.addressLine.trim();
  final String pincode = addressModel.pincode.trim();
  if (pincode.isEmpty) {
    return address;
  }
  return '$address - $pincode';
}

class _HistoryTabBar extends StatelessWidget {
  const _HistoryTabBar({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(10),
        indicator: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        labelColor: scheme.onPrimary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        tabs: const [
          Tab(text: 'Delivered'),
          Tab(text: 'Cancelled'),
          Tab(text: 'Undelivered'),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final OrderStatusEnum status;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color color = switch (status) {
      OrderStatusEnum.delivered => Colors.teal,
      OrderStatusEnum.cancelled || OrderStatusEnum.undelivered => scheme.error,
      _ => scheme.primary,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
