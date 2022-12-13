import 'package:entregas_app/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'UI/Pages/Entregas/entregas_page.dart';
import 'UI/Pages/Login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'listado': (BuildContext context) => ListadoPage()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(elevation: 0))
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
