import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/shop/gems_transaction.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_data/progress_store.dart';
import 'package:vortasks/stores/user_store.dart';

class PurchaseController {
  final baseEndpoint = '/shop/purchases';

  Future<void> startProductPurchase(int productId) async {
    final UserStore userStore = GetIt.I<UserStore>();

    await GetIt.I<ProgressStore>().toRemote();
    final response = await ApiService().post(
      '$baseEndpoint/product/${userStore.user!.id}',
      {'productOrGemsId': productId},
    );

    if (response.statusCode == 201) {
      // Compra bem-sucedida
      await GetIt.I<ProgressStore>().fromRemote();
      // Sincronizar o progresso antes e depois da compra para evitar erros
    } else if (response.statusCode == 403) {
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para comprar o produto');
    } else {
      throw Exception(
          'Erro ao iniciar a compra do produto: ${response.statusCode}');
    }
  }

  Future<GemsTransaction> startGemsPurchase(int gemsPackageId) async {
    final response = await ApiService().post(
      '$baseEndpoint/gems/start',
      {'productOrGemsId': gemsPackageId},
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return GemsTransaction.fromJson(json);
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException('Realize Login em sua conta para comprar gemas');
    } else {
      throw Exception(
          'Erro ao iniciar a compra de gemas: ${response.statusCode}');
    }
  }

  Future<void> completeGemsPurchase(
      String gemsTransactionId, double paymentToken) async {
    final ProgressStore progressStore = GetIt.I<ProgressStore>();
    await progressStore.toRemote();
    final response = await ApiService().post('$baseEndpoint/gems/complete', {
      'gemsTransactionId': gemsTransactionId,
      'paymentToken': paymentToken,
    });

    if (response.statusCode != 200) {
      throw Exception(
          'Erro ao concluir a compra de gemas: ${response.statusCode}');
    }

    // Atualiza os dados locais após a compra
    await progressStore.fromRemote();
  }
}
