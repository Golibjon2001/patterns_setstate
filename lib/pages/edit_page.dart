import 'package:flutter/material.dart';
class EditPage extends StatefulWidget {
  static final String id="editepage";
  String? title,body;
  EditPage({ this.body, this.title,});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle:true,
        title:Text("EditePage"),
      ),
    );
  }
}
