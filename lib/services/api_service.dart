import 'dart:convert';
import 'package:amimobile2/models/login_request_model.dart';
import 'package:amimobile2/models/login_response_model.dart';
import 'package:amimobile2/models/register_request_model.dart';
import 'package:amimobile2/models/register_response_model.dart';
import 'package:amimobile2/config.dart';
import 'package:http/http.dart' as http;
import 'shared_service.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.loginAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    try {
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        // Si l'inscription est réussie (statut 200), on renvoie la réponse
        return registerResponseJson(response.body);
      } else {
        // Si l'inscription échoue, renvoie une erreur dans le modèle de réponse
        return RegisterResponseModel(
          data: null,
          message: "Failed to register. Please try again.",
        );
      }
    } catch (e) {
      // Gestion des exceptions (par exemple, problème de réseau)
      return RegisterResponseModel(
        data: null,
        message: "An error occurred. Please check your connection.",
      );
    }
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
