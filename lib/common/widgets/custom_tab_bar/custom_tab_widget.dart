import 'package:QuIDPe/src/common/widgets/custom_text/custom_text.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class CustomTabWidget extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> views;
  final double? tabHeight;
  final bool isScrollable;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final BorderRadius? borderRadius;

  const CustomTabWidget({
    super.key,
    required this.tabs,
    required this.views,
    this.tabHeight,
    this.isScrollable = false,
    this.backgroundColor,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.borderRadius,
  }) : assert(
         tabs.length == views.length,
         'Tabs and views must have the same length',
       );

  @override
  State<CustomTabWidget> createState() => _CustomTabWidgetState();
}

class _CustomTabWidgetState extends State<CustomTabWidget>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void didUpdateWidget(covariant CustomTabWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _controller.dispose();
      _controller = TabController(length: widget.tabs.length, vsync: this);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final bgColor = widget.backgroundColor ?? Colors.grey.shade100;
    // final indicatorColor = widget.indicatorColor ?? AppColor.whiteColor;
    // final labelColor = widget.labelColor ?? Theme.of(context).primaryColor;
    // final unselectedColor = widget.unselectedLabelColor ?? Colors.black87;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            padding: EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              color: AppColor.dottedLineColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _controller,
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
              tabs: widget.tabs
                  .map(
                    (String tab) => Container(
                      height: widget.tabHeight ?? 40,
                      alignment: Alignment.center,
                      child: CustomText(
                        text: tab,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(controller: _controller, children: widget.views),
        ),
      ],
    );
  }
}
