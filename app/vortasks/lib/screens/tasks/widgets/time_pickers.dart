import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  const TimePickerField({
    super.key,
    required this.label,
    required this.initialTime,
    required this.onTimeChanged,
    this.enabled = true,
    this.backgroundColor = Colors.transparent,
    this.colorText,
    this.borderColor,
  });

  final String label;
  final DateTime initialTime;
  final Function(DateTime) onTimeChanged;
  final bool enabled;
  final Color backgroundColor;
  final Color? colorText;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final hour = initialTime.hour;
    final minute = initialTime.minute;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colorText ?? Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: enabled ? () => _selectTime(context) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: borderColor ?? Colors.white),
              color: backgroundColor,
            ),
            child: Row(
              children: [
                Text(
                  // Formata a data em 00:00
                  '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute}',
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

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialTime),
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true, // Força o formato de 24 horas
          ),
          child: child!, // Renderiza o novo formato
        );
      },
    );

    if (picked != null) {
      // Cria um DateTime com a data de hoje e a hora selecionada
      final selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked.hour,
        picked.minute,
      );

      // Verifica se a data de término é hoje E se a hora selecionada é anterior à hora atual
      if (initialTime.year == DateTime.now().year &&
          initialTime.month == DateTime.now().month &&
          initialTime.day == DateTime.now().day &&
          selectedDateTime.isBefore(DateTime.now())) {
        // Exibe um SnackBar de erro
        _showSnackBar(
            context, 'A hora de término não pode ser anterior à hora atual.');
      } else {
        // Atualiza a hora de término
        onTimeChanged(DateTime(
          initialTime.year,
          initialTime.month,
          initialTime.day,
          picked.hour,
          picked.minute,
        ));
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
