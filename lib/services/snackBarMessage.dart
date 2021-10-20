import 'package:flutter/material.dart';

class snackBarMessage{
 static  success(text){
    return SnackBar(content: Text(text,style: TextStyle(color: Colors.white),),backgroundColor: Colors.lightGreen,);
  }
  static error(text){
    return SnackBar(content: Text(text,style: TextStyle(color: Colors.white)),backgroundColor: Colors.red,);
  }
  static warning(text){
    return SnackBar(content: Text(text,style: TextStyle(color: Colors.white)),backgroundColor: Colors.orange,);
  }
}