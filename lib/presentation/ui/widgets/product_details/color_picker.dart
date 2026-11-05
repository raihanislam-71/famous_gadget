import 'package:bdcalling_class/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.colors,
    required this.onColorSelected,
  });

  final List<Color> colors;
  final Function(Color) onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectedColor = widget.colors.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Color",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: widget.colors.map((item) {
            bool isSelected = _selectedColor == item;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = item;
                });
                widget.onColorSelected(item);
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.themeColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: item,
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 18,
                          color: item == Colors.white ? Colors.black : Colors.white,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
