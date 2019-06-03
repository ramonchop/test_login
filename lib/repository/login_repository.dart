import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:login_test_v2/model/model_user.dart';
import 'package:login_test_v2/services/login_services.dart';

enum Status { 
  Uninitialized, Unauthenticated, Logged, LoggedFinger, Authorized, Authenticating, Logout
}

class LoginRepository extends ChangeNotifier{

  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final LoginServices _services = LoginServices();

  Status _status = Status.Uninitialized;
  User _user;


  LoginRepository.instance() {
    evaluate();
  }

  get status => _status;
  User get user => _user;

  evaluate() async{
    await Future.delayed(Duration(seconds: 2));
    final token = await _storage.read(key: 'token');
    final rut = await _storage.read(key: 'rut');
    if (token == null || token.isEmpty){
      _status = Status.Unauthenticated;
    }else{
      final map = await _storage.readAll();
      _status = Status.LoggedFinger;
      _user = User.fromJson(map, token, rut);
    }
    notifyListeners();
  }

  Future<bool> signIn(String rut, String password) async{
    _status = Status.Authenticating;
    notifyListeners();    
    User user = await _services.login(rut, password);
    if (user == null){
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
    
    await _storage.write(key: 'name', value: user.name);
    await _storage.write(key: 'lastname', value: user.lastname);
    await _storage.write(key: 'token', value: user.token);
    await _storage.write(key: 'rut', value: user.rut);
    await _storage.write(key: 'password', value: password);
    _status = Status.Authorized;
    notifyListeners();
    return true;
    
  }


  Future<bool> signInWithFinger() async{
    bool didAuthenticate = await _localAuth.authenticateWithBiometrics(
    localizedReason: 'Please authenticate to show account balance');
    if (didAuthenticate){
     if (await _services.ping(_user.token, user.rut)){
       _status = Status.Authorized;
       notifyListeners();
       return true;
     }
     return false;
    }else{
      print('NOK');
      return false;
    }    
  }

  Future signOut() async{
    _status = Status.Logout;
    notifyListeners();
    await _storage.deleteAll();
    _status = Status.Unauthenticated;
    notifyListeners();
  }
}