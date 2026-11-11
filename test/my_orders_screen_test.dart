import 'package:bdcalling_class/view/checkout/my_orders_screen.dart';
import 'package:bdcalling_class/view/utils/app_colors.dart';
import 'package:bdcalling_class/view/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('keeps order card text readable in dark theme', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.dark, home: const MyOrdersScreen()),
    );

    final orderNumber = tester.widget<Text>(find.text('#FG-20240315'));
    final orderDate = tester.widget<Text>(find.text('Placed on Mar 15, 2024'));
    final itemCount = tester.widget<Text>(find.text('3 items'));
    final totalLabels = tester.widgetList<Text>(find.text('Total Amount'));

    expect(orderNumber.style?.color, AppColors.navyDark);
    expect(orderDate.style?.color, AppColors.secondaryText);
    expect(itemCount.style?.color, AppColors.navyDark);
    expect(
      totalLabels.every(
        (label) => label.style?.color == AppColors.secondaryText,
      ),
      isTrue,
    );
    expect(tester.takeException(), isNull);
  });
}
