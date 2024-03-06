import 'package:flutter/material.dart';

class MyMessageDialog{
  
  String massage;
  BuildContext context;
  bool isError;


  MyMessageDialog({required this.massage,required this.context,required this.isError});

  AlertDialog get(){

    return AlertDialog(
      title:  Row(
        children: [
          isError? const Padding(padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.highlight_remove,size: 40,color: Colors.red,)):const SizedBox(width: 1,),
          Expanded(child:isError?  const Text('Error'):const Text('Message')),
        ],
      ),
      //  isError? const Text('Error'):const Text('Message'),
      content: isError? Text(massage,style: const TextStyle(
        color: Colors.red, fontWeight: FontWeight.bold
      ),):Text(massage),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          color: Colors.blue,
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}