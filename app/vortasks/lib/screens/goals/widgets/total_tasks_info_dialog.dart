import 'package:flutter/material.dart';

class TotalTasksInfoDialog extends StatelessWidget {
  const TotalTasksInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Total de Tarefas Diárias'),
      content: const Text(
          'Defina a quantidade total de tarefas que você pretende realizar por dia. Essa quantidade será distribuída entre as categorias de Produtividade e Bem-estar de acordo com a proporção definida nesse campo.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
