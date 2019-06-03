import 'package:login_test_v2/constants/url_services.dart';
import 'package:login_test_v2/helpers/login_helper.dart';
import 'package:login_test_v2/model/model_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_test_v2/services/user_services.dart';

class LoginServices{
  
  Future<User> login(String rut, String password) async{
    try{
      final data = LoginHelper.toMap(rut, password);
      final response = await http.post(UrlServices.auth, body: jsonEncode(data));
      if (response == null 
      || response.statusCode != 200){
        return null;
      }else{
        final token = jsonDecode(response.body)['token'];
        final userResponse = await UserServices().getUser(token, rut);
        return userResponse;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> ping(String token, String rut) async{
    final userResponse = await UserServices().getUser(token, rut);
    return userResponse != null;
  }

}