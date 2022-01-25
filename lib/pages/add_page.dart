import 'dart:math';
import 'package:flutter/material.dart';
import 'package:patterns_setstate/model/post_model.dart';
import 'package:patterns_setstate/servise/http_servise.dart';

import 'hom_page.dart';

 class AddPage extends StatefulWidget {
  static final String id = 'create_page';
  const AddPage({Key? key}) : super(key: key);
  @override
  AddPageState createState() => AddPageState();
}


class AddPageState extends State<AddPage> {
  bool isLoading = false;
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _bodyTextEditingController = TextEditingController();

  _apiPostCreate() async {
    setState(() {
      isLoading = true;
    });

    Post post = Post(
        title: _titleTextEditingController.text,
        body: _bodyTextEditingController.text,
        userId: Random().nextInt(99999));

    var response =
    await Network.GET(Network.API_CREATE, Network.paramsCreate(post));

    setState(() {
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomPage.id, (route) => false);
      }

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Title
                Container(
                  height: 50,

                  child: Center(
                    child: TextField(
                      controller: _titleTextEditingController,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Body
                Container(
                  height: 200,
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: _bodyTextEditingController,
                    style: TextStyle(fontSize: 18),
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Body',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          _apiPostCreate();
        },
        child: Icon(Icons.done),
      ),
    );
  }
}