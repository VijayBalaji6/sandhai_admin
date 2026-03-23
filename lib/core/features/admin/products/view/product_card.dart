import 'package:flutter/material.dart';
import 'package:sandhai_admin/config/theme/app_colors.dart';
import 'package:sandhai_admin/core/network/dtos/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool hasImage =
        product.imageUrl != null && product.imageUrl!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasImage ? _networkImage(scheme) : _placeholderIcon(scheme),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _categoryLabel(product.category),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _tag(
                      label: _productTypeLabel(product.productType),
                      background: _productTypeBackground(
                        product.productType,
                        scheme,
                      ),
                      color: scheme.onSurface,
                    ),
                    _tag(
                      label: product.isActive ? 'Active' : 'Inactive',
                      background: product.isActive
                          ? AppColor.lightGreenColor.withValues(alpha: 0.3)
                          : AppColor.greyColor.withValues(alpha: 0.26),
                      color: product.isActive
                          ? AppColor.successColor
                          : scheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _networkImage(ColorScheme scheme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        product.imageUrl!,
        width: 74,
        height: 74,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _placeholderIcon(scheme),
      ),
    );
  }

  Widget _tag({
    required String label,
    required Color background,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  String _productTypeLabel(ProductTypeEnum type) {
    switch (type) {
      case ProductTypeEnum.simple:
        return 'Simple';
      case ProductTypeEnum.bundle:
        return 'Bundle';
    }
  }

  Color _productTypeBackground(ProductTypeEnum type, ColorScheme scheme) {
    switch (type) {
      case ProductTypeEnum.simple:
        return scheme.surfaceContainerHighest;
      case ProductTypeEnum.bundle:
        return AppColor.secondaryLightColor.withValues(alpha: 0.3);
    }
  }

  Widget _placeholderIcon(ColorScheme scheme) {
    return Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(Icons.inventory_2_outlined, color: scheme.onSurfaceVariant),
    );
  }

  String _categoryLabel(ProductCategoryEnum category) {
    switch (category) {
      case ProductCategoryEnum.fruit:
        return 'Fruit';
      case ProductCategoryEnum.vegetable:
        return 'Vegetable';
      case ProductCategoryEnum.dairy:
        return 'Dairy';
    }
  }
}
