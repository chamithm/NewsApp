import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/ui_models/message_dialog.dart';
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
    List user = [];
    try{
      user = await DatabaseProvider.db.getUser();
    }catch(e){
      showDialog(
          context: context,
          builder: (context) => Center(
              child: MyMessageDialog(
                  context: context,
                  isError: true,
                  massage: "Server error")
                  .get()));
    }

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
        child: SizedBox(
          height: 150,
          width: 150,
          child: Image(image: AssetImage('assests/images/newsapplogo.png'),fit: BoxFit.fill,)
        ),
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
          List user = [];
          try{
            user = await DatabaseProvider.db.getUser();
          }catch(e){
            showDialog(
                context: context,
                builder: (context) => Center(
                    child: MyMessageDialog(
                        context: context,
                        isError: true,
                        massage: "Server error")
                        .get()));
          }

          try{
            await DatabaseProvider.db.updateUser({
              "id": 1,
              "username": user[0]['username'],
              "password": user[0]['password'],
              "isLogged": "Y",
              "creation_date": DateTime.now().toString(),
            });
          }catch(e){
            showDialog(
                context: context,
                builder: (context) => Center(
                    child: MyMessageDialog(
                        context: context,
                        isError: true,
                        massage: "Server error")
                        .get()));
          }

          if(user == null){
            return "Don't have an account? Sign up now!";
          }else if(user[0]['username'] != data.name || user[0]['password'] != data.password){
            return "Incorrect User Name or Password";
          }else{
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        onSignup: (data) async{
          await DatabaseProvider.db.createUser({
            "id": 1,
            "username": data.name,
            "password": data.password,
            "isLogged": "Y",
            "creation_date": DateTime.now().toString(),
          });
          Navigator.of(context).pushReplacementNamed('/home');
        },
        onSubmitAnimationCompleted: () {

        },
        onRecoverPassword: (data){

        },
      )
    );
  }
}

