import 'package:shop_minions/model/login.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  int loginId;
  DeleteEvent({this.loginId});
}

class UpdateRequest extends ManageEvent {
  int loginId;
  Login previousLogin;

  UpdateRequest({this.loginId, this.previousLogin});
}

class UpdateCancel extends ManageEvent {}

class SubmitEvent extends ManageEvent {
  Login login;
  SubmitEvent({this.login});
}
