import 'package:examptask/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../models/user_models.dart';
import '../services/http_services.dart';

class DetailPage extends StatefulWidget {
  static const String id = "/detail_page";

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  saveCard () {
    String userName = userNameController.text.trim().toString();
    String relation = relationshipController.text.trim().toString();
    String phone = phoneController.text.trim().toString();

    UserContact user = UserContact(userName: userName, relationship: relation, phoneNumber: phone,);
    Network.POST(Network.API_CREATE, Network.paramsCreate(user)).then((value){
      getResponse(value);
      print(value);

    });

  }

  getResponse(String? response){
    if(response != null){
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomePage.id);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        title: Text(
          "Add Recipients",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 35),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  radius: 12,
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.grey,
                    size: 15,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black26)),
            child: TextField(
              keyboardType: TextInputType.text,
               controller: userNameController,

              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 5, bottom: 10),
                hintText: "Name",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black26)),
            child: TextField(
              keyboardType: TextInputType.text,
               controller: relationshipController,

              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 5, bottom: 10),
                hintText: "Relationship",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black26)),
            child: IntlPhoneField(
              controller: phoneController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 20),
                hintText: 'Phone Number',
                border: InputBorder.none
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            )
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                saveCard();
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 40,horizontal: 30),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue,
                  ),
                  child: Text("Save",style: TextStyle(color: Colors.white),)
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
