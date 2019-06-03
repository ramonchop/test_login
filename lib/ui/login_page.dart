import 'package:flutter/material.dart';
import 'package:login_test_v2/repository/login_repository.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _rut;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _rut = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() { 
    _rut.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginRepo = Provider.of<LoginRepository>(context);
    Status status = loginRepo.status;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          
          padding: EdgeInsets.symmetric(horizontal: 50),
          child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: loginWidgets(loginRepo, status)
         ),
        ),
      )
    );
  }

  List<Widget> loginWidgets(LoginRepository loginRepo, Status status){
    if (status == Status.LoggedFinger){
      return [
        Text('Bienvenido ${loginRepo.user.name} ${loginRepo.user.lastname} '),
        status == Status.Authenticating 
        ? CircularProgressIndicator()
        : RaisedButton(
          onPressed: () => loginRepo.signInWithFinger(),
          child: Text('Login'),
        ),

        status == Status.Logout 
        ? CircularProgressIndicator()
        : RaisedButton(
          onPressed: () => loginRepo.signOut(),
          child: Text('Logout'),
        )
      ];
    }else{
      return [
        TextField(
          controller: _rut,
        ),
        TextField(
          controller: _password,
          obscureText: true,
        ),
        status == Status.Authenticating 
        ? CircularProgressIndicator()
        : RaisedButton(
          onPressed: ()=> loginRepo.signIn(_rut.text, _password.text),
          child: Text('Login'),
        )
      ];
    }
  }
}