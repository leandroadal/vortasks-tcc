import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomAxisTitle extends StatefulWidget {
  final String text;
  final double maxWidth;

  const CustomAxisTitle({super.key, required this.text, this.maxWidth = 40});

  @override
  State<CustomAxisTitle> createState() => _CustomAxisTitleState();
}

class _CustomAxisTitleState extends State<CustomAxisTitle> {
  late List<String> lines = [''];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _calculateLines();
          });
        });
      }
    });
  }

  void _calculateLines() {
    double effectiveMaxWidth = widget.maxWidth;

    List<String> words = widget.text.split(' ');
    lines = [''];
    int currentLine = 0;

    for (var word in words) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(text: '${lines[currentLine]} $word'),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(maxWidth: effectiveMaxWidth);

      if (textPainter.size.width <= effectiveMaxWidth) {
        lines[currentLine] += ' $word';
      } else {
        currentLine++;
        lines.add(word);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.maxWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: lines
            .map((line) => Text(
                  line.trim(),
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                  overflow:
                      TextOverflow.ellipsis, // Adiciona TextOverflow.ellipsis
                ))
            .toList(),
      ),
    );
  }
}
