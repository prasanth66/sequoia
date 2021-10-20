import 'package:flutter/material.dart';
import 'package:sequoia_capital/screens/companies.dart';
import 'package:sequoia_capital/screens/homePage.dart';
import 'package:sequoia_capital/screens/post.dart';
import 'package:sequoia_capital/widgets/sideMenu.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key, required this.userDetails}) : super(key: key);
  final userDetails ;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int index = 0 ;
  String appBarTitle = "Home Page";
  List tabs =[];

  void initState() {
    super.initState();
    tabs =[
      {"screen":HomePage(),"title" : "Home Page"},
      {"screen":Post(userDetails :  widget.userDetails ),"title" : "Post"},
      {"screen":Companies(),"title" : "Companies"},

    ];
  }

  tabChange(value){
    setState(() {
      index = value ;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabs[index]["title"]),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications,color: Colors.grey,),
          ),
        ],
      ),
      drawer: SideMenu(),
      body:tabs[index]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Companies',
          ),

        ],
        currentIndex: index,
        selectedItemColor: Colors.green,
        onTap: tabChange
      ),
    );
  }
}
