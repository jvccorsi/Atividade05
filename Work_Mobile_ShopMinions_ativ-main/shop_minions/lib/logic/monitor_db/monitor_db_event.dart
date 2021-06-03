import 'package:shop_minions/model/login.dart';

abstract class MonitorEvent {}

class AskNewList extends MonitorEvent {}

class UpdateList extends MonitorEvent {
  List<Login> loginList;
  List<int> idList;
  UpdateList({this.loginList, this.idList});
}
