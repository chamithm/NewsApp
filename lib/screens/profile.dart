import 'package:flutter/material.dart';

import '../db/database_provider.dart';
import '../ui_models/message_dialog.dart';
import '../ui_models/my_confirm_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.exit_to_app, color: Colors.white),
          label: const Text('Logout', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent, // Button color
            onPrimary: Colors.white, // Text color
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          ),
          onPressed: () async{
            showDialog(
              context: context,
              builder: (context2) => MyConfirmDialog(
                  title: 'Confirmation',
                  massage: 'Log out now ?',
                  btn1Text: 'Yes',
                  btn2Text: 'No',
                  btn1onPressed: () async{
                    Navigator.of(context2).pop();
                    try{
                      final user = await DatabaseProvider.db.getUser();
                      await DatabaseProvider.db.updateUser({
                        "id": 1,
                        "username": user[0]['username'],
                        "password": user[0]['password'],
                        "isLogged": "N",
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
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                  },
                  btn2onPressed: () {
                    Navigator.of(context2).pop();
                  }).get(),
            );
          },
        ),
      )
    );
  }
}
