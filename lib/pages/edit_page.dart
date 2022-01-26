import 'dart:math';
import 'package:flutter/material.dart';
import 'package:patterns_setstate/model/post_model.dart';
import 'package:patterns_setstate/servise/http_servise.dart';
import 'hom_page.dart';


class UpdatePage extends StatefulWidget {
  static final String id = 'update_page';

  String? title, body;
  UpdatePage({this.title, this.body, Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isLoading = false;
  final TextEditingController _titleTextEditingController = TextEditingController();
  final TextEditingController _bodyTextEditingController = TextEditingController();

  _apiPostUpdate() async {
    setState(() {
      isLoading = true;
    });

    Post post = Post(
        id: Random().nextInt(999),
        title: _titleTextEditingController.text,
        body: _bodyTextEditingController.text,
        userId: Random().nextInt(999));

    var response =
    await Network.PUT(Network.API_UPDATE , Network.paramsUpdate(post));

    setState(() {
      if (response != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomPage.id, (route) => false);
      }

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _titleTextEditingController.text = widget.title!;
    _bodyTextEditingController.text = widget.body!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body:SingleChildScrollView(
        child:Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // Title
                  Container(
                    height: 100,
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: TextField(maxLines: 2,
                        controller: _titleTextEditingController,
                        style: const TextStyle(fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  // Body
                  Container(
                    height: 500,
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      controller: _bodyTextEditingController,
                      style: const TextStyle(fontSize: 20),
                      maxLines: 10,
                      decoration: const InputDecoration(
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
                ? const Center(
                 child: CircularProgressIndicator(),
            ) : const SizedBox.shrink(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          _apiPostUpdate();
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}