class LoginResponseModel{
  bool _Status;
  String _Message;


  LoginResponseModel(this._Status, this._Message);


  bool get Status => _Status;


  set Status(bool value) {
    _Status = value;
  }

  String get Message => _Message;

  set message(String value) {
    _Message = value;
  }
}
