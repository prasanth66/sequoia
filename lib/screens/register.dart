import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sequoia_capital/screens/login.dart';
import 'package:sequoia_capital/services/navigation.dart';
import '../services/snackBarMessage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();



  registerNewUser()async{
    if(passwordController.text.length==0 || confirmPasswordController.text.length==0 || userNameController.text.length==0)
    ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.error("Enter All Fields"));
    else if(confirmPasswordController.text!=passwordController.text)
      ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.error("Password & confirm password dosen't match"));
    else{
      DocumentReference documentReferencer = FirebaseFirestore.instance.collection("users").doc();
      Map<String,dynamic> data = {
        "password"  : passwordController.text,
        "userName"  : userNameController.text,
      };

      await documentReferencer
          .set(data)
          .whenComplete(() => {
        ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.success("User Registerd Successfully")),
        Navigation.pushReplacement(context, Login()),
      })
          .catchError((e) => {
            print(e),
      ScaffoldMessenger.of(context).showSnackBar(snackBarMessage.error("Oops Server Error !!!")),
      });

    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
                  Text('Register',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
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
                  TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      suffixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: Text('Register'),
                      onPressed: registerNewUser,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigation.push(context, Login());
                    },
                    child: Text.rich(
                      TextSpan(
                          text: 'Already have an account',
                          children: [
                            TextSpan(
                              text: '  Login',
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
