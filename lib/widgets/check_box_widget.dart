import 'package:flutter/material.dart';
import 'package:setu_todo/utils/app_colors.dart';

class CircularCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CircularCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? AppColors.appPrimary : AppColors.appText,
            width: 1.0,
          ),
          color: value ? AppColors.appPrimary : Colors.transparent,
        ),
        child: value
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 20.0,
              )
            : null,
      ),
    );
  }
}
