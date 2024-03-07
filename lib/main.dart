import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:newsapp/screens/home.dart';

import 'dashboard.dart';
import 'db/database_provider.dart';

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
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const DashBoard(),
        '/login': (context) => const Login(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final user = await DatabaseProvider.db.getUser();

    print(user);
    if(user == null || user[0]['isLogged'] == "N"){
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
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
        onLogin: (data) async{
          final user = await DatabaseProvider.db.getUser();
          print("user $user");
          return "Incorrect Password";
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Home()));
        },
        onSignup: (data){
          DatabaseProvider.db.createUser({
            "id": 1,
            "username": data.name,
            "password": data.password,
            "isLogged": "Y",
            "creation_date": DateTime.now().toString(),
          });
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

