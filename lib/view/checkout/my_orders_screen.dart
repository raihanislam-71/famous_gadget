import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'order_detail_screen.dart';
import '../navigation/app_navigation.dart';
import 'widgets/orders/order_card.dart';
import 'widgets/orders/order_summary.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key, this.isPreview = false});

  final bool isPreview;

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  static const List<String> _filters = [
    'All',
    'Processing',
    'Shipping',
    'Delivered',
    'Cancelled',
  ];

  static const List<OrderSummary> _orders = [
    OrderSummary(
      number: '#FG-20240315',
      status: 'Processing',
      date: 'Mar 15, 2024',
      itemCount: 3,
      total: '৳28,998',
      statusColor: AppColors.amber,
      statusBackground: Color(0x14F59E0B),
    ),
    OrderSummary(
      number: '#FG-20240311',
      status: 'Shipping',
      date: 'Mar 11, 2024',
      itemCount: 1,
      total: '৳3,200',
      statusColor: AppColors.codPurple,
      statusBackground: Color(0x147C3AED),
    ),
    OrderSummary(
      number: '#FG-20240305',
      status: 'Delivered',
      date: 'Mar 05, 2024',
      itemCount: 2,
      total: '৳1,999',
      statusColor: AppColors.successGreen,
      statusBackground: Color(0x1416A34A),
    ),
    OrderSummary(
      number: '#FG-20240228',
      status: 'Cancelled',
      date: 'Feb 28, 2024',
      itemCount: 1,
      total: '৳4,500',
      statusColor: AppColors.dangerRed,
      statusBackground: Color(0x14E11D48),
    ),
  ];

  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final visibleOrders = _selectedFilter == 'All'
        ? _orders
        : _orders.where((order) => order.status == _selectedFilter).toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 16,
          title: Text(
            'My Orders',
            style: AppTextStyles.h2.copyWith(fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            _buildFilters(),
            Expanded(
              child: visibleOrders.isEmpty
                  ? Center(
                      child: Text(
                        'No ${_selectedFilter.toLowerCase()} orders',
                        style: AppTextStyles.body.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: visibleOrders.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final order = visibleOrders[index];
                        return OrderCard(
                          order: order,
                          onTap: () => AppRoutes.to<void>(
                            route: AppRoutes.orderDetails,
                            arguments: {
                              'orderNumber': order.number,
                              'status': order.status,
                              'isPreview': widget.isPreview,
                            },
                            mobileBuilder: () => OrderDetailScreen(
                              orderNumber: order.number,
                              status: order.status,
                              isPreview: widget.isPreview,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 56,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            for (var index = 0; index < _filters.length; index++) ...[
              if (index > 0) const SizedBox(width: 8),
              _buildFilterChip(_filters[index]),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Material(
      color: isSelected
          ? AppColors.primary
          : Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => setState(() => _selectedFilter = label),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: AppTextStyles.badge.copyWith(
              fontSize: 13,
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
