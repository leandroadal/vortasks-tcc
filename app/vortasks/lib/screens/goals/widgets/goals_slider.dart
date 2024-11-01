import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class GoalsSlider extends StatefulWidget {
  final double sliderValue;
  final Function(double) onChanged;

  const GoalsSlider({
    super.key,
    required this.sliderValue,
    required this.onChanged,
  });

  @override
  State<GoalsSlider> createState() => _GoalsSliderState();
}

class _GoalsSliderState extends State<GoalsSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Definir Equilíbrio entre os Tipos de Tarefas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        Observer(builder: (_) {
          return SfSlider(
            min: 0.0,
            max: 100.0,
            value: widget.sliderValue,
            interval: 10,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Theme.of(context).colorScheme.secondary,
            onChanged: (dynamic newValue) {
              // Converte o newValue para double antes de passar para a função
              widget.onChanged(newValue.toDouble());
            },
          );
        }),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
