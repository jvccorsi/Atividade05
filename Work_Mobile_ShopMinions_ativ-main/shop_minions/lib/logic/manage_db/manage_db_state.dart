import 'package:shop_minions/model/login.dart';

abstract class ManageState {}

class UpdateState extends ManageState {
  int loginId;
  Login previousLogin;
  UpdateState({this.loginId, this.previousLogin});
}

class InsertState extends ManageState {}
