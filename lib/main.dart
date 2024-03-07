import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:newsapp/screens/home.dart';

import 'dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashBoard(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        title: 'NEWS',
        theme: LoginTheme(
          primaryColor: Colors.red[100],
          switchAuthTextColor: Colors.blue,

          cardTheme: const CardTheme(
            color: Colors.white,
          ),
          buttonTheme: const LoginButtonTheme(
            backgroundColor: Colors.red,
          ),
        ),
        logo: const AssetImage('assests/images/newsapplogo.png'),
        onLogin: (data){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
        },
        onSignup: (data){

        },
        onSubmitAnimationCompleted: () {
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => const DashboardScreen(),
          // ));
        },
        onRecoverPassword: (data){

        },
      )
    );
  }
}

