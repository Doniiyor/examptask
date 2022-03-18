import 'package:examptask/pages/detail_page.dart';
import 'package:flutter/material.dart';

import '../models/user_models.dart';
import '../services/http_services.dart';

class HomePage extends StatefulWidget {
  static const String id = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<UserContact> user = [];

  void getCards() {
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((value) {
      setState(() {
        user = Network.parseCards(value);
      });
    });
  }

  void deleteCard (String id,  int index) {
    setState(() {
      user.removeAt(index);
    });
    Network.DEL(Network.API_DELETE + id, Network.paramsEmpty()).then((value) {
    });
  }

  @override
  void initState() {
    getCards();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Beneficiary",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: Icon( Icons.arrow_back_ios,
          color: Colors.black,),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
               // margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                   // border: Border.all(color: Colors.black26)
                   ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  // controller: userNameController,

                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5, bottom: 17),
                    hintText: "Search",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search,color: Colors.grey,),
                    hintStyle: TextStyle(
                      fontSize: 15,color: Colors.grey
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Recipients",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey.shade600),),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: user.length,
                itemBuilder: (context, index){
                  return Dismissible(
                    onDismissed: (DismissDirection direction) async{
                      setState(() async{
                        await Network.DEL(Network.API_DELETE + user[index].id.toString(), Network.paramsEmpty());
                        user.removeAt(index);
                        print ("deleted");
                      });
                    },

                    key: ValueKey(user[index]),
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(backgroundColor: Colors.blue,
                          radius: 20,
                          backgroundImage: AssetImage("assets/images/img${index % 2}.jpg"),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user[index].userName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic),),
                              SizedBox(height: 5,),
                              Text(user[index].phoneNumber,style: TextStyle(color: Colors.blueGrey),),
                            ],
                          ),
                        ),
                        SizedBox(width: 25,),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.blue,
                          ),
                          width: 80,
                          height: 33,
                          child: Text("Send",style: TextStyle(color: Colors.white),),
                        )
                      ],
                      ),
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, DetailPage.id);
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
