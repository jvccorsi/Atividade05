import 'package:shop_minions/data/local/local_database.dart';
import 'package:shop_minions/logic/manage_db/manage_db_event.dart';
import 'package:shop_minions/logic/manage_db/manage_db_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ManageLocalBloc extends Bloc<ManageEvent, ManageState> {
  ManageLocalBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    if (event is DeleteEvent) {
      DatabaseLocalServer.helper.deleteLogin(event.loginId);
    } else if (event is UpdateRequest) {
      yield UpdateState(
          loginId: event.loginId, previousLogin: event.previousLogin);
    } else if (event is UpdateCancel) {
      yield InsertState();
    } else if (event is SubmitEvent) {
      if (state is InsertState) {
        DatabaseLocalServer.helper.insertlogin(event.login);
      } else if (state is UpdateState) {
        UpdateState updateState = state;
        DatabaseLocalServer.helper
            .updateLogin(updateState.loginId, event.login);
        yield InsertState();
      }
    }
  }
}
