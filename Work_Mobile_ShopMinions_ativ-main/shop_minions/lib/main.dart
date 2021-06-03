import 'package:flutter/material.dart';
import 'package:shop_minions/view/tabbar_login/tab_login.dart';

import 'package:shop_minions/view/tela_splash/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(229, 237, 244, 1)),
      home: MainTelaLogin(),
    );
  }
}
