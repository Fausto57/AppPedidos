import 'package:entregas_app/Providers/users_provider.dart';
import 'package:entregas_app/utils/loading_dialog.dart';
import 'package:entregas_app/utils/my_snackbar.dart';
import 'package:entregas_app/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class LoginController {
  late BuildContext context;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  
  SharedPref _sharedPref = new SharedPref();
  late ProgressDialog _progressDialog;

  Future init(BuildContext context) async {
    this.context = context;
    // await usersProvider.init(context);
    phoneController.text = 'Fausto@gmail.com';
    passwordController.text = '1234';
    // User user = User.fromJson(await _sharedPref.read('user') ?? {});
    _progressDialog = ProgressDialog(context: context);
    
    // Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);

    // print('Usuario: ${user.toJson()}');

    // if (user?.sessionToken != null) {
    //   if (user.roles.length > 1) {
    //     Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
    //   } else {
    //     Navigator.pushNamedAndRemoveUntil(
    //         context, user.roles[0].route, (route) => false);
    //   }
    // }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    try {
      LoadingDialog.showLoadingDialog(context, "Iniciando sesión...");
      // _progressDialog.show(max: 100, msg: 'Iniciando sesión...');

      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      var responseApi = await usersProvider.login(phone, password);

      print('Respuesta object: ${responseApi}');
      print('Respuesta: ${responseApi.toJson()}');

      if (responseApi.success) {
      //   // User user = User.fromJson(responseApi.data);
      //   _sharedPref.save('responseApi', responseApi.toJson());

        // await pushNotificationsProvider.saveToken(user.id, user.sessionToken);

        print('USUARIO LOGEADO: ${responseApi.toJson()}');
        if (responseApi != '0') {
          Navigator.pushNamedAndRemoveUntil(context, 'listado', (route) => false);
        } else {
        LoadingDialog.hideLoadingDialog(context);
        MySnackbar.show(context, responseApi.message);
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(context, 'listado', (route) => false);
        }
      } else {
        LoadingDialog.hideLoadingDialog(context);
        MySnackbar.show(context, responseApi.message);
      }
    } catch (e) {
      // LoadingDialog.hideLoadingDialog(context);
      MySnackbar.show(context, 'Error interno, intente más tarde.');

      print(e);
    }
  }
}
