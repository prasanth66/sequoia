import 'package:flutter/material.dart';
import 'package:sequoia_capital/screens/login.dart';
import 'package:sequoia_capital/services/navigation.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: BoxDecoration(

              image: DecorationImage(
                image: AssetImage("assets/images/sequoia.jpg"),
                fit: BoxFit.cover,
              )
            ), child: null,
          
          ),
          ListTile(
            leading: Icon(Icons.verified_user,color: Colors.grey,),
            title: Text('Profile',style: TextStyle(color: Colors.grey,),),
            // onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings,color: Colors.grey,),
            title: Text('Settings',style: TextStyle(color: Colors.grey),),
            // onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color,color: Colors.grey,),
            title: Text('Feedback',style: TextStyle(color: Colors.grey),),
            // onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigation.pushAndRemoveAll(context, Login())},
          ),
        ],
      ),
    );
  }
}
