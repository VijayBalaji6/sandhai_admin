import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sandhai_admin/common/utils/toast_utils.dart';
import 'package:sandhai_admin/common/widgets/custom_button/custom_elevated_button.dart';
import 'package:sandhai_admin/common/widgets/custom_text/custom_text.dart';
import 'package:sandhai_admin/common/widgets/custom_text_field/custom_text_form_field.dart';
import 'package:sandhai_admin/config/theme/app_colors.dart';
import 'package:sandhai_admin/core/features/admin/products/view/product_card.dart';
import 'package:sandhai_admin/common/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:sandhai_admin/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:sandhai_admin/core/network/dtos/order_item_model.dart';
import 'package:sandhai_admin/core/network/dtos/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    final ColorScheme scheme = Theme.of(context).colorScheme;

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
          return CustomScaffold(
            appBar: CustomAppBar(
              title: 'Products',
              trailingWidget: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: state.status == ProductsStatus.loading
                      ? null
                      : () => _showAddProductDialog(context),
                  tooltip: 'Add Product',
                ),
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
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [scheme.surface, scheme.surfaceContainerLowest],
                  ),
                ),
                child: _buildProductsBody(state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsBody(ProductsState state) {
    if (state.products.isEmpty) {
      switch (state.status) {
        case ProductsStatus.loading:
          return _buildEmptyLoadingView();
        case ProductsStatus.failure:
          return _buildEmptyErrorView(state.errorMessage);
        case ProductsStatus.initial:
        case ProductsStatus.loaded:
          return _buildEmptyContentView();
      }
    }

    final Widget productsList = _buildProductsList(state);

    switch (state.status) {
      case ProductsStatus.failure:
        return _buildListErrorView(productsList, state.errorMessage);
      case ProductsStatus.loading:
        return Stack(
          children: [
            productsList,
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(minHeight: 2),
            ),
          ],
        );
      case ProductsStatus.initial:
      case ProductsStatus.loaded:
        return productsList;
    }
  }

  Widget _buildProductsList(ProductsState state) {
    final int activeCount = state.products.where((p) => p.isActive).length;

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
      itemCount: state.products.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildProductsHeader(
            totalCount: state.products.length,
            activeCount: activeCount,
          );
        }
        return ProductCard(product: state.products[index - 1]);
      },
    );
  }

  Widget _buildProductsHeader({
    required int totalCount,
    required int activeCount,
  }) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Your Products',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 6),
                CustomText(
                  text: '$totalCount listed • $activeCount active',
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColor.lightGreenColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              spacing: 6,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.inventory_2_rounded, size: 16),
                CustomText(
                  text: 'Inventory',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyLoadingView() {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 140),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: const Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 14),
              CustomText(
                text: 'Loading products...',
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyErrorView(String? message) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 120),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            spacing: 14,
            children: [
              const Icon(Icons.cloud_off_rounded, color: Colors.red, size: 30),
              CustomText(
                text: message ?? 'Failed to load products',
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
      ],
    );
  }

  Widget _buildEmptyContentView() {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 110),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            spacing: 14,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColor.lightGreenColor.withValues(alpha: 0.24),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.inventory_2_outlined, size: 28),
              ),
              const CustomText(
                text: 'No products yet',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              CustomText(
                text: 'Create your first product to start managing inventory.',
                textAlign: TextAlign.center,
                color: scheme.onSurfaceVariant,
              ),
              CustomElevatedButton(
                buttonName: 'Add Product',
                buttonAction: () => _showAddProductDialog(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListErrorView(Widget productsList, String? message) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  text: message ?? 'Failed to refresh products',
                ),
              ),
              TextButton(
                onPressed: () =>
                    _productsBloc.add(const ProductsFetchRequested()),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        Expanded(child: productsList),
      ],
    );
  }

  Future<void> _showAddProductDialog(BuildContext context) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    ProductCategoryEnum selectedCategory = ProductCategoryEnum.fruit;
    ProductTypeEnum selectedProductType = ProductTypeEnum.simple;
    UnitTypeEnum selectedUnitType = UnitTypeEnum.piece;
    bool isActive = true;
    bool isUploadingImage = false;
    String? uploadedImageUrl;
    Uint8List? selectedImageBytes;

    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const CustomText(text: 'Add Product'),
              content: SizedBox(
                width: 460,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12,
                      children: [
                        CustomTextFormField(
                          controller: nameController,
                          labelText: 'Product Name',
                          hintText: 'Carrot',
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Product name is required';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField<ProductCategoryEnum>(
                          initialValue: selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          items: ProductCategoryEnum.values
                              .map(
                                (ProductCategoryEnum category) =>
                                    DropdownMenuItem<ProductCategoryEnum>(
                                      value: category,
                                      child: Text(
                                        _productCategoryLabel(category),
                                      ),
                                    ),
                              )
                              .toList(),
                          onChanged: (ProductCategoryEnum? value) {
                            if (value == null) return;
                            setState(() => selectedCategory = value);
                          },
                        ),
                        DropdownButtonFormField<ProductTypeEnum>(
                          initialValue: selectedProductType,
                          decoration: const InputDecoration(
                            labelText: 'Product Type',
                            border: OutlineInputBorder(),
                          ),
                          items: ProductTypeEnum.values
                              .map(
                                (ProductTypeEnum type) =>
                                    DropdownMenuItem<ProductTypeEnum>(
                                      value: type,
                                      child: Text(_productTypeLabel(type)),
                                    ),
                              )
                              .toList(),
                          onChanged: (ProductTypeEnum? value) {
                            if (value == null) return;
                            setState(() => selectedProductType = value);
                          },
                        ),
                        DropdownButtonFormField<UnitTypeEnum>(
                          initialValue: selectedUnitType,
                          decoration: const InputDecoration(
                            labelText: 'Unit Type',
                            border: OutlineInputBorder(),
                          ),
                          items: UnitTypeEnum.values
                              .map(
                                (UnitTypeEnum type) =>
                                    DropdownMenuItem<UnitTypeEnum>(
                                      value: type,
                                      child: Text(_unitTypeLabel(type)),
                                    ),
                              )
                              .toList(),
                          onChanged: (UnitTypeEnum? value) {
                            if (value == null) return;
                            setState(() => selectedUnitType = value);
                          },
                        ),
                        Row(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                controller: quantityController,
                                labelText: 'Quantity',
                                hintText: '1',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                validator: (String? value) {
                                  final double? quantity = double.tryParse(
                                    value?.trim() ?? '',
                                  );
                                  if (quantity == null || quantity <= 0) {
                                    return 'Enter valid quantity';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomTextFormField(
                                controller: priceController,
                                labelText: 'Price',
                                hintText: '45.00',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                validator: (String? value) {
                                  final double? price = double.tryParse(
                                    value?.trim() ?? '',
                                  );
                                  if (price == null || price <= 0) {
                                    return 'Enter valid price';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: 'Product Photo',
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(height: 10),
                              if (selectedImageBytes != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.memory(
                                    selectedImageBytes!,
                                    width: double.infinity,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else
                                Container(
                                  width: double.infinity,
                                  height: 84,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    text: 'No photo selected',
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              const SizedBox(height: 10),
                              FilledButton.icon(
                                onPressed: isUploadingImage
                                    ? null
                                    : () async {
                                        final ProductCategoryEnum category =
                                            selectedCategory;

                                        setState(() {
                                          isUploadingImage = true;
                                        });

                                        final UploadPhotoResult? uploadResult =
                                            await _pickAndUploadProductPhoto(
                                              category: category,
                                            );
                                        if (!mounted) {
                                          return;
                                        }

                                        if (uploadResult == null) {
                                          setState(() {
                                            isUploadingImage = false;
                                          });
                                          return;
                                        }

                                        setState(() {
                                          isUploadingImage = false;
                                          selectedImageBytes =
                                              uploadResult.bytes;
                                          uploadedImageUrl =
                                              uploadResult.publicUrl;
                                        });
                                      },
                                icon: isUploadingImage
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.upload_rounded),
                                label: CustomText(
                                  text: isUploadingImage
                                      ? 'Uploading...'
                                      : selectedImageBytes == null
                                      ? 'Upload Photo'
                                      : 'Change Photo',
                                ),
                              ),
                              if (uploadedImageUrl != null) ...[
                                const SizedBox(height: 8),
                                CustomText(
                                  text:
                                      'Uploaded to: products/${_sanitizeStorageSegment(_productCategoryLabel(selectedCategory))}/...',
                                  fontSize: 12,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ],
                            ],
                          ),
                        ),
                        SwitchListTile.adaptive(
                          value: isActive,
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Active'),
                          onChanged: (bool value) {
                            setState(() => isActive = value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    if (!(formKey.currentState?.validate() ?? false)) {
                      return;
                    }
                    _productsBloc.add(
                      ProductsCreateRequested(
                        name: nameController.text.trim(),
                        category: selectedCategory,
                        imageUrl: uploadedImageUrl,
                        isActive: isActive,
                        productType: selectedProductType,
                        unitType: selectedUnitType,
                        quantity: double.parse(quantityController.text.trim()),
                        price: double.parse(priceController.text.trim()),
                      ),
                    );
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }

  String _productTypeLabel(ProductTypeEnum type) {
    switch (type) {
      case ProductTypeEnum.simple:
        return 'Simple';
      case ProductTypeEnum.bundle:
        return 'Bundle';
    }
  }

  String _unitTypeLabel(UnitTypeEnum type) {
    switch (type) {
      case UnitTypeEnum.kg:
        return 'KG';
      case UnitTypeEnum.g:
        return 'G';
      case UnitTypeEnum.piece:
        return 'Piece';
      case UnitTypeEnum.dozen:
        return 'Dozen';
      case UnitTypeEnum.bundle:
        return 'Bundle';
    }
  }

  Future<UploadPhotoResult?> _pickAndUploadProductPhoto({
    required ProductCategoryEnum category,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: kIsWeb ? null : 85,
        maxWidth: kIsWeb ? null : 1600,
      );

      if (pickedFile == null) {
        return null;
      }

      final Uint8List bytes = await pickedFile.readAsBytes();
      final String safeCategory = _sanitizeStorageSegment(
        _productCategoryLabel(category),
      );
      final String extension = _fileExtension(pickedFile.name);
      final String mimeType =
          pickedFile.mimeType ?? _contentTypeFromExtension(extension);

      if (!mimeType.startsWith('image/')) {
        ToastUtils.showErrorToast('Please select a valid image file.');
        return null;
      }

      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}.${extension}';
      final String storagePath = 'products/$safeCategory/$fileName';

      final SupabaseClient client = Supabase.instance.client;
      await client.storage
          .from('products')
          .uploadBinary(
            storagePath,
            bytes,
            fileOptions: FileOptions(upsert: true, contentType: mimeType),
          );

      final String publicUrl = client.storage
          .from('products')
          .getPublicUrl(storagePath);

      ToastUtils.showSuccessToast('Photo uploaded');
      return UploadPhotoResult(bytes: bytes, publicUrl: publicUrl);
    } on StorageException catch (e) {
      ToastUtils.showErrorToast('Upload failed: ${e.message}');
      return null;
    } catch (e) {
      ToastUtils.showErrorToast('Photo upload failed: $e');
      return null;
    }
  }

  String _sanitizeStorageSegment(String value) {
    final String lower = value.trim().toLowerCase();
    final String alnumAndSpaces = lower.replaceAll(
      RegExp(r'[^a-z0-9\s_-]'),
      '',
    );
    final String collapsed = alnumAndSpaces.replaceAll(RegExp(r'\s+'), '_');
    return collapsed.isEmpty ? 'uncategorized' : collapsed;
  }

  String _productCategoryLabel(ProductCategoryEnum category) {
    switch (category) {
      case ProductCategoryEnum.fruit:
        return 'Fruit';
      case ProductCategoryEnum.vegetable:
        return 'Vegetable';
      case ProductCategoryEnum.dairy:
        return 'Dairy';
    }
  }

  String _fileExtension(String fileName) {
    final int index = fileName.lastIndexOf('.');
    if (index == -1 || index == fileName.length - 1) {
      return 'jpg';
    }
    return fileName.substring(index + 1).toLowerCase();
  }

  String _contentTypeFromExtension(String extension) {
    switch (extension) {
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      case 'jpg':
      case 'jpeg':
      default:
        return 'image/jpeg';
    }
  }
}

class UploadPhotoResult {
  const UploadPhotoResult({required this.bytes, required this.publicUrl});

  final Uint8List bytes;
  final String publicUrl;
}
