import 'dart:convert';

import 'package:login_test_v2/constants/url_services.dart';
import 'package:login_test_v2/helpers/login_helper.dart';
import 'package:login_test_v2/model/model_user.dart';
import 'package:http/http.dart' as http;
class UserServices {

  Future<User> getUser(String token, String rut) async{
    final headers = {
      'SII-TOKEN': token,
    };
    final data = LoginHelper.toMapRut(rut);
    //validar data != null
    final response = await http.post(
      UrlServices.coreRiac, headers: headers, body: jsonEncode(data));
    if (response == null || response.statusCode != 200){
      return null;
    }else{
      return User.fromJson(jsonDecode(response.body), token, rut);
    }
  }
}