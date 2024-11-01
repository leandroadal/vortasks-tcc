import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:vortasks/core/storage/local_storage.dart';

class IconManager {
  static final IconManager _instance = IconManager._internal();

  factory IconManager() => _instance;

  IconManager._internal();

  // Diretório para armazenar os ícones
  Future<Directory> get _iconDirectory async {
    final directory = await getApplicationDocumentsDirectory();
    final iconDir = Directory('${directory.path}/icons');
    if (!await iconDir.exists()) {
      await iconDir.create(recursive: true);
    }
    return iconDir;
  }

  // Baixa e salva o ícone localmente
  Future<String?> downloadAndSaveIcon(String iconUrl) async {
    final response = await http.get(Uri.parse(iconUrl));
    if (response.statusCode == 200) {
      final iconDir = await _iconDirectory;
      final fileName = iconUrl.split('/').last;
      final filePath = '${iconDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      await LocalStorage.saveData(iconUrl, filePath);
      return filePath;
    }
    return null;
  }

  // Obtém o caminho do ícone local, se ele existir
  Future<String?> getLocalIconPath(String iconUrl) async {
    return LocalStorage.getString(iconUrl);
  }
}
