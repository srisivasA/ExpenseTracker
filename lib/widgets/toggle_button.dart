import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  ToggleButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? (title == "Income" ? Colors.green.shade100 : Colors.red.shade100)
                : Colors.grey.shade200,
            border: Border.all(
              color: isSelected
                  ? (title == "Income" ? Colors.green : Colors.red)
                  : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? (title == "Income" ? Colors.green : Colors.red)
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
