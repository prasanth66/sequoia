import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

      stream: FirebaseFirestore.instance.collection("posts").orderBy("timeStamp",descending: true).snapshots(),
      builder: (context,AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (BuildContext context,int index){
            int pointer = index ;
            return Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              padding: EdgeInsets.all(10),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white10.withOpacity(0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.face,color: Colors.green,size: 40,),
                          Column(
                            children: [
                              Text(snapshot.data.docs[pointer]["userName"].toString()),
                              Text(DateFormat('jm').format(snapshot.data.docs[pointer]["timeStamp"].toDate()).toString()),

                            ],
                          )
                        ],
                      ),
                      Text(DateFormat('yMMMMd').format(snapshot.data.docs[pointer]["timeStamp"].toDate()).toString()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        snapshot.data.docs[pointer]["post"].toString()
                    ),
                  ),

                ],
              ),
            );
          },
        );
        // return Text(
        //   snapshot.data.docs[0]["post"].toString()
        // );
      }
    );
  }
}
