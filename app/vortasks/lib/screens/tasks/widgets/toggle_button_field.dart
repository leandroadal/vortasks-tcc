import 'package:flutter/material.dart';

class ToggleButtonWidget extends StatelessWidget {
  final List<String> options;
  final List<bool> isSelected;
  final Function(int) onOptionSelected;
  final Color? selectedBackgroundColor;

  const ToggleButtonWidget({
    super.key,
    required this.options,
    required this.isSelected,
    required this.onOptionSelected,
    this.selectedBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButtons(
              onPressed: onOptionSelected,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderColor: Colors.white70,
              selectedBorderColor: const Color.fromARGB(255, 2, 0, 37),
              selectedColor: Colors.black,
              fillColor: selectedBackgroundColor ??
                  Theme.of(context).colorScheme.primary,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: isSelected,
              children: options
                  .map((option) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          option,
                          style: TextStyle(
                              color: isSelected[options.indexOf(option)]
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onPrimary // Cor do texto selecionado
                                  : Colors.white, // Cor do texto padrão
                              fontWeight: FontWeight.w500),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
