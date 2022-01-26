import 'package:flutter/material.dart';
import 'package:patterns_setstate/pages/add_page.dart';
import 'package:patterns_setstate/pages/edit_page.dart';
import 'package:patterns_setstate/pages/hom_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:HomPage(),
      routes:{
        HomPage.id:(context)=>HomPage(),
        AddPage.id:(context)=>AddPage(),
        UpdatePage.id:(context)=>UpdatePage(),
      },
    );
  }
}

