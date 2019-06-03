class LoginHelper {
  static Map<String, dynamic> toMap(String rut, String password){
    final _rut = rut.substring(0,rut.length-1);
    final _dv = rut.substring(_rut.length);
    return{
      'rut': _rut,
      'dv': _dv,
      'clave': password
    };
  }

  static Map<String, dynamic> toMapRut(String rut){
    final _rut = rut.substring(0,rut.length-1);
    final _dv = rut.substring(_rut.length);
    return{
      'rut': _rut,
      'dv': _dv,
    };
  }

  static String token(Map<String, dynamic> data){
    return data['token'];
  } 
}