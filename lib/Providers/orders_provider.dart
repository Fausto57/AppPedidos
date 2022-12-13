import 'dart:convert';
import 'dart:developer';
import 'package:entregas_app/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/order.dart';
import '../utils/environment.dart';

class OrdersProvider {
  String _url = Environment.API;
  String _api = '/api';
  late BuildContext context;

  Future init(BuildContext context) async{
    this.context = context;
  }

  Future<List<Order>> getByStatus(String status) async {
    try {
      late Uri url;
      // print('SESION TOKEN: ${sessionUser.sessionToken}');
      if(status == 'TERMINADO'){
        url = Uri.http(_url, '$_api/ObtenerTerminados');
      }else{
        url = Uri.http(_url, '$_api/ObtenerEntrega');
      }
      log(url.toString());
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode != 201 && res.statusCode != 200) {
        final data = json.decode(res.body); // CATEGORIAS
        // Fluttertoast.showToast(msg: data['message']);
        // new SharedPref().logout(context, sessionUser.id);
      }
      print(res.body);
      List<dynamic> data = json.decode(res.body); // CATEGORIAS
      log('data');
      print(data);
      Order order = Order.fromJsonList(data);
      log('list');
      print(order.toList);
      return order.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
Future<List<Order>> putPedido(String status, int idPedido) async {
    try {
      late Uri url;
      // print('SESION TOKEN: ${sessionUser.sessionToken}');
      if(status == 'TERMINADO'){
        url = Uri.http(_url, '$_api/UpdateTerminados');
      }else{
        url = Uri.http(_url, '$_api/UpdateEntrega');
      }
      log(url.toString());
      Map<String, String> headers = {
        'Content-type': 'application/json'
      };
      String bodyParams = json.encode({'idLineaPedido': idPedido});
      
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode != 201 && res.statusCode != 200) {
        final data = json.decode(res.body); // CATEGORIAS
        // Fluttertoast.showToast(msg: data['message']);
        // new SharedPref().logout(context, sessionUser.id);
      }
      print(res.body);
      List<dynamic> data = json.decode(res.body); // CATEGORIAS
      log('data');
      print(data);
      Order order = Order.fromJsonList(data);
      log('list');
      print(order.toList);
      return order.toList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

}
