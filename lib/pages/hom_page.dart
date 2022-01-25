import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_setstate/model/post_model.dart';
import 'package:patterns_setstate/servise/http_servise.dart';

import 'add_page.dart';
import 'edit_page.dart';
class HomPage extends StatefulWidget {
  static final String id="Hompage";
  const HomPage({Key? key}) : super(key: key);

  @override
  _HomPageState createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  bool isLoading=false;
  List<Post>itms=[];


  void _apiPostList()async{
    setState(() {
      isLoading=true;
    });
   var respons=await Network.GET(Network.API_LIST,Network.paramsEmpty());
   setState(() {
     if(respons!=null){
       itms=Network.parsePostList(respons);
     }else{
       itms=[];
     }
     isLoading=false;
   });
  }

  void _apiPostDelete(Post post)async{
    setState(() {
      isLoading=true;
    });
    var response=await Network.DEL(Network.API_DELETE+post.id.toString(),Network.paramsEmpty());
    if(response!=null){
      _apiPostList();
    }else{
      isLoading=false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text("setState"),
        centerTitle:true,
      ),
      body:Stack(
        children: [
          ListView.builder(
            itemCount:itms.length,
              itemBuilder:(ctx,x){
              return itemOPost(itms[x]);
              }
          ),
        isLoading ?
          const Center(
            child:CircularProgressIndicator(),
          ):const SizedBox.shrink(),
        ],
      ),
      floatingActionButton:FloatingActionButton(
        onPressed:(){
          Navigator.pushNamed(context,AddPage.id);
        },
        backgroundColor:Colors.blue,
        foregroundColor:Colors.white,
        child:Icon(Icons.add),
      ),
    );
  }
  Widget itemOPost(Post post){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
        child: Container(
          padding:const EdgeInsets.only(left:20,right:20,top:20),
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(post.title!.toUpperCase(),style:const TextStyle(color:Colors.black,fontWeight:FontWeight.bold),),
              const SizedBox(height:10,),
              Text(post.body!)
            ],
          ),
        ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Update',
          color: Colors.indigo,
          icon: Icons.edit,
          onTap: () {
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _apiPostDelete(post);
          },
        ),
      ],
    );
  }
}
