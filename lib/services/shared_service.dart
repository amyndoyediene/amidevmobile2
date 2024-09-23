import 'dart:convert';
import 'dart:typed_data';
import 'package:amimobile2/models/login_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class SharedService {
  static final CacheManager _cacheManager = DefaultCacheManager();

  static Future<bool> isLoggedIn() async {
    var fileInfo = await _cacheManager.getFileFromCache("login_details");
    return fileInfo != null; // Vérifie si le fichier existe dans le cache
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var fileInfo = await _cacheManager.getFileFromCache("login_details");

    if (fileInfo != null) {
      var cacheData = await fileInfo.file.readAsString();
      return loginResponseJson(cacheData);
    }
    return null;
  }

  static Future<void> setLoginDetails(LoginResponseModel loginResponse) async {
    var cacheData = jsonEncode(loginResponse.toJson());
    await _cacheManager.putFile("login_details", Uint8List.fromList(cacheData.codeUnits)); // Convertit la chaîne en Uint8List
  }

  static Future<void> logout(BuildContext context) async {
    await _cacheManager.removeFile("login_details");
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}
