import 'package:flutter/material.dart';


class Navigation{
  static push(context,screen){
    Navigator.push(
        context,
      MaterialPageRoute(builder: (BuildContext context)=>screen),
    );
  }
  static pushReplacement(context,screen){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => screen,
      ),
    );
  }
  static pushAndRemoveAll(context,screen){
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
       builder: (context)=>screen,
      ),
        (route)=>false
    );
  }
  static pop(context){
    Navigation.pop(context);
  }
}