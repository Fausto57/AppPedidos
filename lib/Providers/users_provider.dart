import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:entregas_app/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../models/response_api.dart';
import '../utils/environment.dart';

class UsersProvider {
  String _url = Environment.API;
  String _api = '/api';
  String verificationId = "";
  late BuildContext context;
  // late User sessionUser;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<ResponseApi> login(String correo, String password) async {
    ResponseApi responseApi = ResponseApi();
    try {
      Uri url = Uri.http(_url, '$api/login');
      // Uri url = Uri.parse(_url + '/auth/login');

      String bodyParams = json.encode({'Correo': correo, 'Contraseña': password});
      print(bodyParams);
      Map<String, String> headers = {'Content-type': 'application/json'};
      log(url.toString());
      final res = await http.post(url, headers: headers, body: bodyParams);
      if (res.statusCode == 201 || res.statusCode == 200) {
        final data = json.decode(res.body);
        log(res.toString());
        responseApi = ResponseApi(message: "Usuario encontrado", error: "Usuario encontrado", success: true);

        // if (data['success'] == true) {
        //   if (data['data']['roles'] != null) {
        //     print(data['data']['roles']);
        //     data['data']['roles'] = json.decode(data['data']['roles']);
        //   responseApi = ResponseApi.fromJson(data);
        //   }
        // } else {
        //   responseApi = ResponseApi.fromJson(data);
        // }
      } else {
        responseApi = ResponseApi(message: "Usuario no encontrado", error: "Usuario no encontrado", success: false);
      }
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return responseApi;
    }
  }
}
