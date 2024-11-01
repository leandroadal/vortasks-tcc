import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:vortasks/exceptions/bad_token_exception.dart';
import 'package:vortasks/models/shop/gems_package.dart';
import 'package:vortasks/services/api_service.dart';
import 'package:vortasks/stores/user_store.dart';

class GemsController {
  final baseEndpoint = '/shop/gemsPackage';

  Future<List<GemsPackage>> getGemsPackages() async {
    final response = await ApiService().get(
      '$baseEndpoint/page',
    );

    if (response.statusCode == 200) {
      final List<dynamic> json =
          jsonDecode(utf8.decode(response.bodyBytes))['content'] as List;

      return json.map((e) => GemsPackage.fromJson(e)).toList();
    } else if (response.statusCode == 403) {
      final userStore = GetIt.I<UserStore>();
      if (userStore.token != null) {
        userStore.setUser(null);
        userStore.setToken(null);
      }
      throw BadTokenException(
          'Realize Login em sua conta para ver os pacotes de gemas disponíveis');
    } else {
      throw Exception('Pacotes de gemas indisponíveis no momento');
    }
  }
}
