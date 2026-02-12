import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  final TabController? tabController;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: AppColor.dottedLineColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: tabController,
        dividerColor: AppColor.transparent,
        indicator: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        unselectedLabelStyle: const TextStyle(
          color: AppColor.blackColor,
          fontWeight: FontWeight.bold,
        ),
        labelStyle: const TextStyle(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        labelColor: AppColor.primaryColor,
        unselectedLabelColor: AppColor.blackColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColor.primaryColor,
        tabs: tabs,
      ),
    );
  }
}
