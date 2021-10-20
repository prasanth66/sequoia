import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyCard extends StatelessWidget {
   CompanyCard({Key? key,@required this.company}) : super(key: key);
  final  company ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),

      child: Stack(

        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(company["imageUrl"])
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              company["title"],
              style: TextStyle(
                  color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Positioned(
           bottom: 0,
            right: 0,
            child: Container(
              // width: double.infinity,
              padding: EdgeInsets.all(10.0),
              color: Colors.lightGreen.withOpacity(0.3),
              child: Center(child: Text("READ THEIR STORY")),
            ),
          )
        ],
      ),
    );
  }
}
