import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/screens/rewards/achievement_widget.dart';
import 'package:vortasks/screens/rewards/checkin_widget.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';
import 'package:vortasks/stores/shop/sell_store.dart';
import 'package:vortasks/stores/user_data/check_in/checkin_store.dart';

class RewardsScreen extends StatelessWidget {
  RewardsScreen({super.key});

  final CheckInStore _checkInStore = GetIt.I<CheckInStore>();
  final SellStore _sellStore = GetIt.I<SellStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Recompensas'),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Observer(
                builder: (_) => _buildCurrencyDisplay(context),
              ),
              const SizedBox(height: 32.0),
              _buildCheckInSection(context),
              const SizedBox(height: 16.0),
              const AchievementWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  Widget _buildCurrencyDisplay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.diamond, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 8.0),
            Observer(
              builder: (_) => Text(
                'Gemas: ${_sellStore.gems}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/icons/shop/money-icon.png',
              height: 25,
              width: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 8.0),
            Observer(
              builder: (_) => Text(
                'Moedas: ${_sellStore.coins}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget com estado para o check-in
  Widget _buildCheckInSection(BuildContext context) {
    return CheckInWidget(
      checkInStore: _checkInStore,
      sellStore: _sellStore,
    );
  }
}
