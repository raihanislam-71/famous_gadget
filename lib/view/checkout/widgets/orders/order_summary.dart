import 'package:flutter/material.dart';

class OrderSummary {
  const OrderSummary({
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
