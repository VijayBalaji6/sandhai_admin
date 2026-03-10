import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/common/utils/toast_utils.dart';
import 'package:sandhai_admin/common/widgets/custom_text/custom_text.dart';
import 'package:sandhai_admin/core/features/admin/products/view/product_card.dart';
import 'package:sandhai_admin/common/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import '../bloc/products_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();
    _productsBloc = ProductsBloc()..add(const ProductsFetchRequested());
  }

  @override
  void dispose() {
    _productsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsBloc>.value(
      value: _productsBloc,
      child: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (BuildContext context, ProductsState state) {
          if (state.errorMessage != null) {
            ToastUtils.showErrorToast(state.errorMessage!);
            _productsBloc.add(const ProductsMessageCleared());
          }
          if (state.successMessage != null) {
            ToastUtils.showSuccessToast(state.successMessage!);
            _productsBloc.add(const ProductsMessageCleared());
          }
        },
        builder: (BuildContext context, ProductsState state) {
          if (state.status == ProductsStatus.loading &&
              state.products.isEmpty) {
            return const CustomScaffold(
              appBar: CustomAppBar(title: 'Products'),
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.status == ProductsStatus.failure &&
              state.products.isEmpty) {
            return CustomScaffold(
              appBar: const CustomAppBar(title: 'Products'),
              body: Center(
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: state.errorMessage ?? 'Failed to load products',
                      textAlign: TextAlign.center,
                    ),
                    FilledButton.icon(
                      onPressed: () =>
                          _productsBloc.add(const ProductsFetchRequested()),
                      icon: const Icon(Icons.refresh),
                      label: const CustomText(text: 'Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          return CustomScaffold(
            appBar: CustomAppBar(
              title: 'Products',
              trailingWidget: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: state.status == ProductsStatus.loading
                      ? null
                      : () => _productsBloc.add(const ProductsFetchRequested()),
                  tooltip: 'Refresh',
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                _productsBloc.add(const ProductsFetchRequested());
                await Future<void>.delayed(const Duration(milliseconds: 500));
              },
              child: state.products.isEmpty
                  ? const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: 200,
                        child: Center(child: Text('No products yet')),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(product: state.products[index]);
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
