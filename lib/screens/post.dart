import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/snackBarMessage.dart';
import 'package:firebase_core/firebase_core.dart';

class Post extends StatefulWidget {
  const Post({Key? key,required this.userDetails}) : super(key: key);
  final userDetails ;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  final postController = TextEditingController();

  post()async{

    if(postController.text.length==0)
      ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.error("Post is Empty"));
    else{
      DocumentReference documentReferencer = FirebaseFirestore.instance.collection("posts").doc();

      Map<String,dynamic> data = {
        "userName"  : widget.userDetails["userName"],
        "post"  : postController.text,
        "comment" : [],
        "likes" : 0,
        "timeStamp" : DateTime.now()
      };
      await documentReferencer
          .set(data)
          .whenComplete(() => {
      ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.success("Post shared successfully")),
        postController.text = ""
      })
          .catchError((e) => {
      ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.error("Server error")),
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.face,color: Colors.green,size: 40,),
                  Text(widget.userDetails["userName"]),
                ],
              ),
              Container(
                color: Colors.white24,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextButton(
                    onPressed: post,
                    child: Text(
                        "POST",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    )),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 10,
              controller: postController,
              keyboardType: TextInputType.multiline,
              autofocus: true,
              decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
            ),
          ),

        ],
      ),
    );
  }
}
