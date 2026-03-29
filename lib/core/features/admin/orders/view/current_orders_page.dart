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

class CurrentOrdersPage extends StatefulWidget {
  const CurrentOrdersPage({super.key});

  @override
  State<CurrentOrdersPage> createState() => _CurrentOrdersPageState();
}

class _CurrentOrdersPageState extends State<CurrentOrdersPage> {
  late final OrdersBloc _ordersBloc;
  late final OrdersRepository _ordersRepository;
  late final UsersRepository _usersRepository;
  Map<String, String> _userNamesByPhone = const {};
  Map<String, UserAddressModel> _addressesById = const {};

  @override
  void initState() {
    super.initState();
    _ordersBloc = OrdersBloc()
      ..add(const OrdersFetchRequested(filterMode: OrdersFilterMode.all));
    _ordersRepository = OrdersRepository();
    _usersRepository = UsersRepository();
    _loadUserNames();
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
        filterMode: OrdersFilterMode.all,
      ),
    );
    _loadUserNames();
  }


  @override
  void dispose() {
    _ordersBloc.close();
    super.dispose();
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
              title: 'Current Orders',
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
                  onPressed: state.status == OrdersStatus.loading
                      ? null
                      : _refresh,
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

    return Stack(
      children: [
        DefaultTabController(
          length: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                child: _PrimaryTabBar(scheme: scheme),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildOrderListTab(
                      orders: _filterByStatus(state.orders, OrderStatusEnum.ordered),
                      state: state,
                      showActions: true,
                    ),
                    _buildOrderListTab(
                      orders: _filterByStatus(
                        state.orders,
                        OrderStatusEnum.accepted,
                      ),
                      state: state,
                      showActions: true,
                    ),
                    _buildOrderListTab(
                      orders: _filterByStatus(
                        state.orders,
                        OrderStatusEnum.packing,
                      ),
                      state: state,
                      showActions: true,
                    ),
                    _buildOrderListTab(
                      orders: _filterByStatus(
                        state.orders,
                        OrderStatusEnum.outForDelivery,
                      ),
                      state: state,
                      showActions: true,
                    ),
                    _buildOtherStatusesTab(state, scheme),
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
}

class _PrimaryTabBar extends StatelessWidget {
  const _PrimaryTabBar({required this.scheme});

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
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        labelColor: scheme.onPrimary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        tabs: const [
          Tab(text: 'Ordered'),
          Tab(text: 'Accepted'),
          Tab(text: 'Packing'),
          Tab(text: 'Out for delivery'),
          Tab(text: 'Others'),
        ],
      ),
    );
  }
}

class _SecondaryTabBar extends StatelessWidget {
  const _SecondaryTabBar({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: scheme.surfaceContainerHigh.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(8),
        indicator: BoxDecoration(
          color: scheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        labelColor: scheme.onSecondaryContainer,
        unselectedLabelColor: scheme.onSurfaceVariant,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
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

List<OrderModel> _filterByStatus(
  List<OrderModel> orders,
  OrderStatusEnum status,
) {
  return orders.where((order) => order.status == status).toList();
}

extension on _CurrentOrdersPageState {
  Widget _buildOtherStatusesTab(OrdersState state, ColorScheme scheme) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
            child: _SecondaryTabBar(scheme: scheme),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildOrderListTab(
                  orders: _filterByStatus(state.orders, OrderStatusEnum.delivered),
                  state: state,
                ),
                _buildOrderListTab(
                  orders: _filterByStatus(state.orders, OrderStatusEnum.cancelled),
                  state: state,
                ),
                _buildOrderListTab(
                  orders: _filterByStatus(
                    state.orders,
                    OrderStatusEnum.undelivered,
                  ),
                  state: state,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderListTab({
    required List<OrderModel> orders,
    required OrdersState state,
    bool showActions = false,
  }) {
    if (state.status == OrdersStatus.loading && orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        _ordersBloc.add(
          const OrdersFetchRequested(filterMode: OrdersFilterMode.all),
        );
        await Future<void>.delayed(const Duration(milliseconds: 250));
      },
      child: orders.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 120),
                Center(child: Text('No orders in this tab')),
              ],
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = orders[index];
                final bool isUpdating = state.updatingOrderId == order.id;
                final String? customerName =
                    _userNamesByPhone[order.userPhone.trim()];
                final UserAddressModel? address = order.addressId == null
                    ? null
                    : _addressesById[order.addressId!.trim()];
                return _OrderCard(
                  order: order,
                  customerName: customerName,
                  address: address,
                  showActions: showActions,
                  isUpdating: isUpdating,
                  onViewDetails: () => _showOrderDetailsPopup(
                    order,
                    customerName: customerName,
                    address: address,
                  ),
                  onNext: () => _ordersBloc.add(
                    OrderStatusAdvanced(
                      id: order.id,
                      currentStatus: order.status,
                    ),
                  ),
                  onCancel: () => _ordersBloc.add(
                    OrderStatusSetRequested(
                      id: order.id,
                      status: OrderStatusEnum.cancelled,
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
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    required this.customerName,
    required this.address,
    required this.showActions,
    required this.isUpdating,
    required this.onViewDetails,
    required this.onNext,
    required this.onCancel,
  });

  final OrderModel order;
  final String? customerName;
  final UserAddressModel? address;
  final bool showActions;
  final bool isUpdating;
  final VoidCallback onViewDetails;
  final VoidCallback onNext;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      elevation: 0,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#${order.id.substring(0, 8)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (customerName?.isNotEmpty == true) ...[
                          Text(
                            customerName!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: scheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                        ],
                        Text(
                          order.userPhone,
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        if (order.createdAt != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            DateTimeUtils.getFormattedDateTime(
                              dateTimeData: order.createdAt,
                              dateTimeFormat: DateFormatUtils.ddMMMYYhhmmA,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                _formattedDeliveryAddress(address),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '₹${order.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: scheme.primary,
                    ),
                  ),
                  const Spacer(),
                  _CompactAction(
                    tooltip: 'View order details',
                    onPressed: onViewDetails,
                    foreground: scheme.secondary,
                    child: Icon(
                      Icons.receipt_long_outlined,
                      size: 18,
                      color: scheme.secondary,
                    ),
                  ),
                  if (showActions) ...[
                    const SizedBox(width: 8),
                    _CompactAction(
                      tooltip: 'Next status',
                      onPressed: isUpdating ? null : onNext,
                      foreground: scheme.primary,
                      child: isUpdating
                          ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: scheme.primary,
                              ),
                            )
                          : Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: scheme.primary,
                            ),
                    ),
                    const SizedBox(width: 8),
                    _CompactAction(
                      tooltip: 'Cancel order',
                      onPressed: isUpdating ? null : onCancel,
                      foreground: scheme.error,
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: scheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
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

/// Small circular tap targets — not full-width bar buttons.
class _CompactAction extends StatelessWidget {
  const _CompactAction({
    required this.tooltip,
    required this.onPressed,
    required this.foreground,
    required this.child,
  });

  final String tooltip;
  final VoidCallback? onPressed;
  final Color foreground;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: foreground.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
