import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.colors,
    this.colorNames,
    this.onColorSelected,
  });

  final List<Color> colors;
  final List<String>? colorNames;
  final ValueChanged<Color>? onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor = widget.colors.first;

  String _getColorName(Color color, int index) {
    if (widget.colorNames != null && index < widget.colorNames!.length) {
      return widget.colorNames![index];
    }
    if (color == Colors.black || color == const Color(0xFF1E293B)) {
      return 'Matte Black';
    }
    if (color == Colors.white) return 'Pure White';
    if (color == Colors.orange || color == AppColors.primary) {
      return 'Sunset Orange';
    }
    if (color == Colors.blue) return 'Ocean Blue';
    if (color == Colors.grey) return 'Space Gray';
    if (color == Colors.red) return 'Crimson Red';
    return 'Color ${index + 1}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedIndex = widget.colors.indexOf(_selectedColor);
    final selectedName = selectedIndex >= 0
        ? _getColorName(_selectedColor, selectedIndex)
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Select Color',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (selectedName.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                '•  $selectedName',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: List.generate(widget.colors.length, (index) {
            final item = widget.colors[index];
            final isSelected = _selectedColor == item;
            return Tooltip(
              message: _getColorName(item, index),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = item;
                  });
                  widget.onColorSelected?.call(item);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : theme.dividerColor,
                      width: isSelected ? 2.5 : 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: item,
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: item.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
