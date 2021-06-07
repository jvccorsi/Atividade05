import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_minions/logic/manage_db/manage_db_event.dart';
import 'package:shop_minions/logic/manage_db/manage_local_db_bloc.dart';
import 'package:shop_minions/logic/manage_db/manage_remote_db_bloc.dart';
import 'package:shop_minions/logic/monitor_db/monitor_db_state.dart';
import 'package:shop_minions/logic/monitor_db/montior_db_bloc.dart';
import 'package:shop_minions/model/login.dart';
import 'package:flutter/material.dart';

class LoginList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginListState();
  }
}

class _LoginListState extends State<LoginList> {
  List colorLocation = [Colors.red, Colors.blue, Colors.yellow];
  List iconLocation = [
    Icons.error_outline,
    Icons.settings_cell,
    Icons.network_check_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
      return getLoginListView(state.loginList, state.idList);
    });
  }

  ListView getLoginListView(loginList, idList) {
    return ListView.builder(
      itemCount: loginList.length,
      itemBuilder: (context, position) {
        return Card(
          color: colorLocation[loginList[position].dataLocation],
          elevation: 5,
          child: ListTile(
            leading: Icon(iconLocation[loginList[position].dataLocation]),
            title: Text('Nome do usuário: ' + loginList[position].email),
            subtitle: Text('Senha do usuário: ' + loginList[position].senha),
            onTap: () {},
            trailing: GestureDetector(
                onTap: () {
                  if (loginList[position].dataLocation == 1) {
                    BlocProvider.of<ManageLocalBloc>(context)
                        .add(DeleteEvent(loginId: idList[position]));
                  } else if (loginList[position].dataLocation == 2) {
                    BlocProvider.of<ManageRemoteBloc>(context)
                        .add(DeleteEvent(loginId: idList[position]));
                  }
                },
                child: Icon(Icons.delete)),
          ),
        );
      },
    );
  }
}
