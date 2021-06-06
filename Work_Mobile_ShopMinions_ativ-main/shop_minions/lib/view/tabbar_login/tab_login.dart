import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_minions/logic/manage_db/manage_local_db_bloc.dart';
import 'package:shop_minions/logic/manage_db/manage_remote_db_bloc.dart';
import 'package:shop_minions/logic/monitor_db/montior_db_bloc.dart';
import 'package:shop_minions/view/tela_login_atvd4/tela_atvd4.dart';
import 'package:shop_minions/view/login_list/login_list.dart';

class MainTelaLogin extends StatelessWidget {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MonitorBloc()),
            BlocProvider(create: (_) => ManageLocalBloc()),
            BlocProvider(create: (_) => ManageRemoteBloc()),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Atvd.4",
                    style: TextStyle(
                        color: Color.fromRGBO(12, 59, 102, 1),
                        fontSize: 30,
                        fontFamily: 'Bree Serif'),
                  ),
                  Image.asset('assets/images/logo_app_bar.png'),
                ],
              ),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.shopping_bag_outlined), text: 'Login'),
                  Tab(icon: Icon(Icons.people), text: 'Visualizar inserção'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                MainTelaAtvd4(),
                LoginList(),
              ],
            ),
          ),
        ));
  }
}
