import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class NumberedPaginationWidget extends StatelessWidget {
  final int totalItems;
  final int pageSize;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const NumberedPaginationWidget({
    super.key,
    required this.totalItems,
    required this.pageSize,
    required this.currentPage,
    required this.onPageChanged,
  });

  int get totalPages => (totalItems / pageSize).ceil();

  List<int?> _getPageList() {
    const int maxVisiblePages = 2;
    List<int?> pages = [];

    if (totalPages <= maxVisiblePages + 2) {
      pages = List.generate(totalPages, (index) => index + 1);
    } else {
      if (currentPage <= 2) {
        pages = [1, 2, 3, null, totalPages];
      } else if (currentPage >= totalPages - 1) {
        pages = [1, null, totalPages - 2, totalPages - 1, totalPages];
      } else {
        pages = [
          1,
          null,
          currentPage - 1,
          currentPage,
          currentPage + 1,
          null,
          totalPages,
        ];
      }
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final List<int?> pages = _getPageList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavButton(
          icon: Icons.chevron_left,
          enabled: currentPage > 1,
          onPressed: () => onPageChanged(currentPage - 1),
        ),
        ...pages.map((page) {
          if (page == null) {
            return _buildEllipsis();
          } else {
            return _buildPageButton(page);
          }
        }),
        _buildNavButton(
          icon: Icons.chevron_right,
          enabled: currentPage < totalPages,
          onPressed: () => onPageChanged(currentPage + 1),
        ),
      ],
    );
  }

  Widget _buildPageButton(int page) {
    final bool isSelected = page == currentPage;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onPageChanged(page),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.greyGreenColor : AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.grey7Color),
          ),
          child: CustomText(
            text: '$page',
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColor.whiteColor : AppColor.greyGreenColor,
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.grey7Color),
          ),
          child: Icon(
            icon,
            color: enabled ? AppColor.greyGreenColor : AppColor.grey7Color,
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.grey7Color),
      ),
      child: CustomText(
        text: '...',
        color: AppColor.primaryColor,
        fontSize: 18,
      ),
    );
  }
}
