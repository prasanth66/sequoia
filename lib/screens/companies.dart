import 'package:flutter/material.dart';
import '../widgets/companyCard.dart';


class Companies extends StatefulWidget {
  const Companies({Key? key}) : super(key: key);

  @override
  _CompaniesState createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  @override
  List companies = [
    {"imageUrl":'assets/images/appleCompany.jpg',"title":"Apple"},
    {"imageUrl":'assets/images/byjusCompany.jpg',"title":"Byjus"},
    {"imageUrl":'assets/images/ciscoCompany.jpg',"title":"Cisco"},
    {"imageUrl":'assets/images/zomatoCompany.jpg',"title":"Zomato"},
    {"imageUrl":'assets/images/linkedinCompany.png',"title":"Linkedin"},
  ];
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (BuildContext context,int index){
        return CompanyCard(company:companies[index]);
      },
    );
  }
}
