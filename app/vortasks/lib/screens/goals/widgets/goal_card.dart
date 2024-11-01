import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final String cardType;
  final TextEditingController productivityController;
  final TextEditingController wellBeingController;
  final Function(int) calculatePercentage;
  final Function(String) updatePercentagesFromGoals;
  final VoidCallback updateWeeklyFromDaily;
  final VoidCallback updateDailyFromWeekly;

  const GoalCard({
    super.key,
    required this.cardType,
    required this.productivityController,
    required this.wellBeingController,
    required this.calculatePercentage,
    required this.updatePercentagesFromGoals,
    required this.updateWeeklyFromDaily,
    required this.updateDailyFromWeekly,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meta $cardType',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Campo para a meta de produtividade
            TextFormField(
              controller: productivityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                    'Produtividade (${calculatePercentage(int.tryParse(productivityController.text) ?? 0)}%)',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um número';
                }
                return null;
              },
              onChanged: (value) {
                updatePercentagesFromGoals(cardType);
                if (cardType == 'Diária') {
                  updateWeeklyFromDaily();
                } else {
                  updateDailyFromWeekly();
                }
              },
            ),
            const SizedBox(height: 16.0),
            // Campo para a meta de bem-estar
            TextFormField(
              controller: wellBeingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                    'Bem-estar (${calculatePercentage(int.tryParse(wellBeingController.text) ?? 0)}%)',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um número';
                }
                return null;
              },
              onChanged: (value) {
                updatePercentagesFromGoals(cardType);
                if (cardType == 'Diária') {
                  updateWeeklyFromDaily();
                } else {
                  updateDailyFromWeekly();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
