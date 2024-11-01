import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vortasks/models/checkin/check_in.dart';
import 'package:vortasks/stores/shop/sell_store.dart';
import 'package:vortasks/stores/user_data/check_in/checkin_store.dart';

class CheckInWidget extends StatefulWidget {
  final CheckInStore checkInStore;
  final SellStore sellStore;

  const CheckInWidget({
    super.key,
    required this.checkInStore,
    required this.sellStore,
  });

  @override
  State<CheckInWidget> createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  bool _isCheckInDone = false;

  @override
  void initState() {
    super.initState();
    _checkLastCheckIn(); // Verifica o último check-in na inicialização
  }

  @override
  Widget build(BuildContext context) {
    final checkIns = widget.checkInStore.checkIns;
    final consecutiveDays = _calculateConsecutiveCheckIns(checkIns);

    // Calcula a próxima recompensa
    int nextCoins = 10;
    int nextGems = 0;
    if ((consecutiveDays + 1) % 7 == 0) {
      nextCoins += 10;
      nextGems += 10;
    }

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Check-in diário',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Mostra a próxima recompensa
            _buildRewardRow(nextCoins, nextGems, context),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isCheckInDone
                  ? null // Desabilita o botão se o check-in já foi feito hoje
                  : () {
                      HapticFeedback.lightImpact();
                      widget.checkInStore.checkIn();
                      _giveCheckInRewards();
                      setState(() {
                        _isCheckInDone =
                            true; // Desabilita o botão após o check-in
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.card_giftcard, size: 20),
                  SizedBox(width: 8.0),
                  Text('Resgatar Recompensa',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Dias consecutivos: $consecutiveDays', // Exibe a contagem de dias consecutivos
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para exibir a linha de recompensa
  Widget _buildRewardRow(int coins, int gems, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (coins > 0)
          Row(
            children: [
              Image.asset(
                'assets/icons/shop/money-icon.png', // caminho da imagem de moeda
                height: 30,
                width: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8.0),
              Text(
                '$coins',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        if (gems > 0)
          Row(
            children: [
              const SizedBox(width: 16.0),
              Icon(Icons.diamond,
                  color: Theme.of(context).colorScheme.secondary, size: 30),
              const SizedBox(width: 8.0),
              Text(
                '$gems',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
      ],
    );
  }

  // Função para dar as recompensas de check-in
  void _giveCheckInRewards() {
    int consecutiveDays = _calculateConsecutiveCheckIns(
        widget.checkInStore.checkIns); // Calcula os dias consecutivos

    widget.sellStore.incrementCoins(10); // Recompensa padrão de moedas

    if (consecutiveDays % 7 == 0) {
      widget.sellStore.incrementGems(10); // Recompensa de gemas a cada 7 dias
      widget.sellStore
          .incrementCoins(10); // Recompensa adicional de moedas a cada 7 dias
    }
  }

  // Função para calcular a quantidade de check-ins consecutivos
  int _calculateConsecutiveCheckIns(List<CheckIn> checkIns) {
    final now = DateTime.now().toUtc();
    int consecutiveDays = 0;

    // Ordena os check-ins por data decrescente
    checkIns.sort((a, b) => b.lastCheckInDate!.compareTo(a.lastCheckInDate!));

    // Verifica se há check-ins consecutivos
    for (int i = 0; i < checkIns.length; i++) {
      final checkInDate = checkIns[i].lastCheckInDate;
      if (checkInDate == null) {
        break; // Não há data de check-in, então a sequência é quebrada
      }

      final expectedDate = now.subtract(Duration(days: i));
      if (checkInDate.year != expectedDate.year ||
          checkInDate.month != expectedDate.month ||
          checkInDate.day != expectedDate.day) {
        break; // A data do check-in não é a esperada, então a sequência é quebrada
      }

      consecutiveDays++;
    }

    return consecutiveDays;
  }

  // Verifica se o último check-in foi hoje
  void _checkLastCheckIn() {
    final now = DateTime.now().toUtc();
    final checkIns = widget.checkInStore.checkIns;

    _isCheckInDone = checkIns.any((checkIn) =>
        checkIn.year == now.year &&
        checkIn.month == now.month &&
        checkIn.lastCheckInDate?.day == now.day);
  }
}
