import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login_page.dart';
import 'auth.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
    Widget build(BuildContext context){

      return new MaterialApp(
        title: 'Flutter login demo bro',
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        home: new LoginPage(auth: new Auth()),
      );
    }
}
