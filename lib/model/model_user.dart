class User{
  String _name;
  String _lastname;
  String _token;
  String _rut;

  get name => _name;
  get lastname => _lastname;
  get token => _token;
  get rut => _rut;

  User.fromJson(Map<String, dynamic> map, token, rut){
    _name = map['nombres'] ?? map['name'];
    _lastname = map['apellidos'] ?? map['lastname'];
    _token = token;
    _rut = rut;
  }

}