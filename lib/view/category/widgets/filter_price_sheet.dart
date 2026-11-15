import 'package:flutter/material.dart';

class FilterPriceSheet extends StatefulWidget {
  final RangeValues initialRange;
  final Function(RangeValues) onApply;

  const FilterPriceSheet({
    super.key,
    required this.initialRange,
    required this.onApply,
  });

  @override
  State<FilterPriceSheet> createState() => _FilterPriceSheetState();
}

class _FilterPriceSheetState extends State<FilterPriceSheet> {
  late RangeValues selectedRange;

  @override
  void initState() {
    super.initState();
    selectedRange = widget.initialRange;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Filter by price',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            RangeSlider(
              values: selectedRange,
              min: 0,
              max: 100000,
              divisions: 20,
              labels: RangeLabels(
                '৳${selectedRange.start.round()}',
                '৳${selectedRange.end.round()}',
              ),
              onChanged: (range) => setState(() => selectedRange = range),
            ),
            FilledButton(
              onPressed: () {
                widget.onApply(selectedRange);
                Navigator.pop(context);
              },
              child: const Text('Apply filters'),
            ),
          ],
        ),
      ),
    );
  }
}
