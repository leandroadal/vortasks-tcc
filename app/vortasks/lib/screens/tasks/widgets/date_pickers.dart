import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    super.key,
    this.label,
    required this.initialDate,
    required this.onDateChanged,
    this.enabled = true,
    this.backgroundColor = Colors.transparent,
    this.minimumDate,
    this.maximumDate,
    this.colorText,
    this.borderColor,
  });

  final String? label;
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;
  final bool enabled;
  final Color backgroundColor;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final Color? colorText;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style: TextStyle(
                  color: colorText ?? Colors.white,
                  fontSize: 16,
                ),
              )
            : Container(),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: enabled ? () => _selectDate(context) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor ?? Colors.white),
              color: backgroundColor,
            ),
            child: Row(
              children: [
                Text(
                  '${initialDate.day.toString().padLeft(2, '0')}/${initialDate.month.toString().padLeft(2, '0')}/${initialDate.year}',
                  style: TextStyle(
                    color: colorText ?? Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate:
          minimumDate ?? DateTime.now(), // Usa a data mínima se fornecida
      lastDate: maximumDate ?? DateTime(2101), // Usa a data máxima se fornecida
    );

    if (picked != null && picked != initialDate) {
      if (minimumDate != null && picked.isBefore(minimumDate!)) {
        _showSnackBar(context, 'A data não pode ser anterior a $minimumDate');
      } else if (maximumDate != null && picked.isAfter(maximumDate!)) {
        _showSnackBar(context, 'A data não pode ser posterior a $maximumDate');
      } else {
        onDateChanged(picked.add(Duration(
          hours: initialDate.hour,
          minutes: initialDate.minute,
        )));
      }
    }
  }

  void _showSnackBar(BuildContext? context, String message) {
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }
}
