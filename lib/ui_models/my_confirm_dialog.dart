import 'package:flutter/material.dart';

class MyConfirmDialog{

  String title;

  String massage;

  String btn1Text;

  String btn2Text;

  VoidCallback btn1onPressed;

  VoidCallback btn2onPressed;

  MyConfirmMsgTypes? type;

  MyConfirmDialog({required this.title,required this.massage,
    required this.btn1Text, required this.btn2Text,
    required this.btn1onPressed,required this.btn2onPressed,this.type});

  AlertDialog get(){

    Widget? icon;
    if(type==MyConfirmMsgTypes.warning){
      icon=const Padding(padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.warning,size: 40,color: Colors.deepOrangeAccent,));
    }else if(type==MyConfirmMsgTypes.delete){
      icon=const Padding(padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.highlight_remove,size: 40,color: Colors.red,));
    }else if(type==MyConfirmMsgTypes.ok){
      icon=const Padding(padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.check_circle,size: 40,color: Colors.green,));
    }

    return AlertDialog(
      title: Row(
        children: [
          icon?? const SizedBox(width: 1,),
          Expanded(child: Text(title)),
        ],
      ),
      content: Text(massage),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          color: Colors.blueAccent,
          onPressed: btn1onPressed,
          child: Text(
            btn1Text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          elevation: 5.0,
          color: Colors.grey,
          onPressed: btn2onPressed,
          child: Text(
            btn2Text,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

enum MyConfirmMsgTypes{normal,delete,warning,ok}