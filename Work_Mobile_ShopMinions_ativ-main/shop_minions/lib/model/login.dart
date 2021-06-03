class Login {
  int _dataLocation;
  String _email;
  String _senha;

  Login() {
    /*
      0 = undefined
      1 = local
      2 = internet
    */
    _dataLocation = 1;
    _email = "";
    _senha = "";
  }
//Receber um map(dicionario) para instanciar os atrb.
  Login.fromMap(map) {
    this._email = map["email"];
    this._senha = map["senha"];
    this._dataLocation = map["dataLocation"];
  }

  String get email => _email;
  String get senha => _senha;
  int get dataLocation => _dataLocation;

  set email(String newemail) {
    if (newemail.length > 0) {
      this._email = newemail;
    }
  }

  set senha(String newsenha) {
    if (newsenha.length > 0) {
      this._senha = newsenha;
    }
  }

  set dataLocation(int newLocation) {
    if (newLocation > 0 && newLocation < 3) {
      this._dataLocation = newLocation;
    }
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["email"] = _email;
    map["senha"] = _senha;
    return map;
  }
}
