import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/shop/product.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_store.dart';

class ProductController {
  final baseEndpoint = '/shop/product';

  Future<List<Product>> searchProducts({
    String name = '',
    String category = '',
    int page = 0,
    int linesPerPage = 15,
    String orderBy = 'name',
    String direction = 'ASC',
  }) async {
    final queryParams = {
      'name': name,
      'category': category,
      'page': page.toString(),
      'linesPerPage': linesPerPage.toString(),
      'orderBy': orderBy,
      'direction': direction,
    };

    final response = await ApiService().get('$baseEndpoint/page', queryParams);

    if (response.statusCode == 200) {
      final List<dynamic> json =
          jsonDecode(utf8.decode(response.bodyBytes))['content'] as List;
      return json.map((e) => Product.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para ver os itens disponíveis');
    } else {
      throw Exception('Itens indisponíveis no momento');
    }
  }

  Future<List<Product>> getPurchasedProducts() async {
    final response = await ApiService().get('$baseEndpoint/purchased');

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      return json.map((e) => Product.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para ver seus produtos');
    } else {
      throw Exception(
          'Erro ao obter produtos comprados: ${response.statusCode}');
    }
  }
}
