import 'dart:async';

import 'package:shop_minions/data/local/local_database.dart';
import 'package:shop_minions/data/web_server/remote_database.dart';
import 'package:shop_minions/logic/monitor_db/monitor_db_event.dart';
import 'package:shop_minions/logic/monitor_db/monitor_db_state.dart';
import 'package:shop_minions/model/login.dart';
import 'package:bloc/bloc.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _localSubscription;
  StreamSubscription _remoteSubscription;

  List<Login> localLoginList;
  List<Login> remoteLoginList;
  List<int> localIdList;
  List<int> remoteIdList;

  MonitorBloc() : super(MonitorState(loginList: [], idList: [])) {
    add(AskNewList());
    _localSubscription = DatabaseLocalServer.helper.stream.listen((response) {
      try {
        localLoginList = response[0];
        localIdList = response[1];
        add(UpdateList(
            loginList: List.from(localLoginList)..addAll(remoteLoginList),
            idList: List.from(localIdList)..addAll(remoteIdList)));
      } catch (e) {}
    });
    _remoteSubscription = DatabaseRemoveServer.helper.stream.listen((response) {
      try {
        remoteLoginList = response[0];
        remoteIdList = response[1];
        add(UpdateList(
            loginList: List.from(localLoginList)..addAll(remoteLoginList),
            idList: List.from(localIdList)..addAll(remoteIdList)));
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var localResponse = await DatabaseLocalServer.helper.getLoginList();
      var remoteResponse = await DatabaseRemoveServer.helper.getLoginList();
      localLoginList = localResponse[0];
      localIdList = localResponse[1];
      remoteLoginList = remoteResponse[0];
      remoteIdList = remoteResponse[1];
      yield MonitorState(
          loginList: List.from(localLoginList)..addAll(remoteLoginList),
          idList: List.from(localIdList)..addAll(remoteIdList));
    } else if (event is UpdateList) {
      yield MonitorState(idList: event.idList, loginList: event.loginList);
    }
  }

  close() {
    _localSubscription.cancel();
    _remoteSubscription.cancel();
    return super.close();
  }
}
