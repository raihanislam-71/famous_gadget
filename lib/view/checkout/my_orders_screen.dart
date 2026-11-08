import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'order_detail_screen.dart';

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

  static const List<_OrderSummary> _orders = [
    _OrderSummary(
      number: '#FG-20240315',
      status: 'Processing',
      date: 'Mar 15, 2024',
      itemCount: 3,
      total: '৳28,998',
      statusColor: AppColors.amber,
      statusBackground: Color(0x14F59E0B),
    ),
    _OrderSummary(
      number: '#FG-20240311',
      status: 'Shipping',
      date: 'Mar 11, 2024',
      itemCount: 1,
      total: '৳3,200',
      statusColor: AppColors.codPurple,
      statusBackground: Color(0x147C3AED),
    ),
    _OrderSummary(
      number: '#FG-20240305',
      status: 'Delivered',
      date: 'Mar 05, 2024',
      itemCount: 2,
      total: '৳1,999',
      statusColor: AppColors.successGreen,
      statusBackground: Color(0x1416A34A),
    ),
    _OrderSummary(
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
    final visibleOrders = _selectedFilter == 'All'
        ? _orders
        : _orders.where((order) => order.status == _selectedFilter).toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.pageBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.navyDark,
          elevation: 0,
          scrolledUnderElevation: 0,
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
                          color: AppColors.secondaryText,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: visibleOrders.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final order = visibleOrders[index];
                        return _OrderCard(
                          order: order,
                          onTap: () => Get.to<void>(
                            () => OrderDetailScreen(
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
      color: isSelected ? AppColors.primary : AppColors.surface,
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
              color: isSelected ? AppColors.surface : AppColors.navyDark,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderSummary {
  const _OrderSummary({
    required this.number,
    required this.status,
    required this.date,
    required this.itemCount,
    required this.total,
    required this.statusColor,
    required this.statusBackground,
  });

  final String number;
  final String status;
  final String date;
  final int itemCount;
  final String total;
  final Color statusColor;
  final Color statusBackground;
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order, required this.onTap});

  final _OrderSummary order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.number,
                    style: AppTextStyles.badge.copyWith(fontSize: 15),
                  ),
                  _OrderStatusBadge(order: order),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: AppColors.border),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Placed on ${order.date}',
                        style: AppTextStyles.caption.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${order.itemCount} '
                        '${order.itemCount == 1 ? 'item' : 'items'}',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13,
                          height: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Amount',
                        style: AppTextStyles.caption.copyWith(fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order.total,
                        style: AppTextStyles.badge.copyWith(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderStatusBadge extends StatelessWidget {
  const _OrderStatusBadge({required this.order});

  final _OrderSummary order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: order.statusBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        order.status,
        style: AppTextStyles.badge.copyWith(
          fontSize: 11,
          color: order.statusColor,
        ),
      ),
    );
  }
}
