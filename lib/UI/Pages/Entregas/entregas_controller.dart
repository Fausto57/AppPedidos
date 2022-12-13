import 'dart:developer';

import 'package:entregas_app/Providers/orders_provider.dart';
import 'package:entregas_app/models/order.dart';
import 'package:entregas_app/utils/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:entregas_app/utils/shared_pref.dart';

class EntregasListController {

  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  late Function refresh;

  List<String> status = ['TERMINADO', 'ENTREGAS'];
  OrdersProvider _ordersProvider = new OrdersProvider();

  // bool isUpdated;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // user = User.fromJson(await _sharedPref.read('user'));

    _ordersProvider.init(context);
    refresh();
  }

  Future<List<Order>> getOrders(String status) async {
    return await _ordersProvider.getByStatus(status);
  }

  putPedido(String status, int idPedido) async {
    LoadingDialog.showLoadingDialog(context, "Actualizando...");
    var result = await _ordersProvider.putPedido(status, idPedido);
    refresh();
    LoadingDialog.hideLoadingDialog(context);
    return result;
  }
  
}