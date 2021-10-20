import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../services/navigation.dart';
import './register.dart';
import '../services/snackBarMessage.dart';
import '../widgets/bottomBar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  login()async{
    if(passwordController.text.length==0 ||  userNameController.text.length==0)
      ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.error("Enter All Fields"));
    else{

      Map<String,dynamic> userDetails = {
        "userName" : userNameController.text
      };

      QuerySnapshot documentReferencer = await FirebaseFirestore.instance.collection('users')
      .where(
        'password',isEqualTo:passwordController.text,
      ).where(
        'userName',isEqualTo:userNameController.text,
      ).get();

      if(documentReferencer.docs.length>=1){
        Navigation.pushReplacement(context, BottomBar(userDetails : userDetails));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.error("Wrong Credentials"));
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
          child: Container(
            height: height,
            width: width,
            margin: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    height: height*0.20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/loginImage.jpg',),
                      ),
                    ),

                  ),
                  Text('Login',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                  SizedBox(height: 30.0,),
                  TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      hintText: 'User Name',
                      suffixIcon: Icon(Icons.face),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: Icon(Icons.visibility_off),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: Text('Login'),
                      onPressed: login,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigation.pushReplacement(context, Register());
                    },
                    child: Text.rich(
                      TextSpan(
                          text: 'Don\'t have an account',
                          children: [
                            TextSpan(
                              text: '  Register',
                              style: TextStyle(
                                  color: Color(0xffEE7B23)
                              ),
                            ),
                          ]
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
