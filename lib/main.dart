import 'package:flutter/material.dart';
import 'package:login_test_v2/repository/login_repository.dart';
import 'package:login_test_v2/ui/home_page.dart';
import 'package:login_test_v2/ui/login_page.dart';
import 'package:login_test_v2/ui/splash_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      home: ChangeNotifierProvider<LoginRepository>(
        builder: (_) => LoginRepository.instance(),
        child: Consumer(
          builder: (context, LoginRepository loginRepo, _){
            switch(loginRepo.status){
              case Status.Uninitialized:
                return SplashPage();
              case Status.Authorized:
                return HomePage();

              // case Status.Unauthenticated:
              // case Status.Authenticating:
              // case Status.Logged:
              // case Status.LoggedFinger:
              default:
                return LoginPage();
            }
          },
        ),
        
      )
    );
  }
}




