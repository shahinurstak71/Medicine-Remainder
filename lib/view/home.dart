

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:medicineremainder/view/addmedicine.dart';

import '../widget/drawer_widget.dart';
import 'feedback/feedback.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdvancedDrawerController _drawerController=AdvancedDrawerController();
  List<String>getDatalist=[];

  FirebaseAuth auth=FirebaseAuth.instance;

  // Future getUserData()async{
  //   await FirebaseFirestore.instance.collection("user").get().then((value){
  //     value.docs.forEach((element){
  //       getDatalist.add(element.reference.id);
  //     });
  //     setState(() {
  //     });
  //   });
  // }
  @override
  void initState() {
    // getUserData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.indigoAccent,
      controller: _drawerController,
      animationDuration: Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
      animateChildDecoration: true,
      rtlOpening: false,
      drawer:
      StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection("user").snapshots(),
        builder:(context,snapshot){
         if(snapshot.hasData){
           return ListView.builder(
               itemCount:snapshot.data!.docs.length,
               primary: false,
               shrinkWrap: true,
               itemBuilder: (context,index){
                 QueryDocumentSnapshot document= snapshot.data!.docs[index];
                 return  auth.currentUser!.uid==document["id"]? DrawerWidget(
                   imageurl: document["photo"],
                   name: document["name"],
                   email:document["email"] ,
                 ):Container();
               });
         }
         else{
           return Text("LOADING . . . .");
         }

         // ListView.builder(
            //   itemCount:
            //   primary: false,
            //   shrinkWrap: true,
            //   itemBuilder: (context,index){
            //     QueryDocumentSnapshot document=snapshot.data!.docs[index];
            //     return  auth.currentUser!.uid==document["uid"]? DrawerWidget(
            //       imageurl: document["photo"],
            //       name: document["name"],
            //     ):Container();
            //   });
        },
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              _drawerController.showDrawer();
            },
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _drawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          title: Text("Medicine Remainder"),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (){


                },
                icon: Icon(Icons.notifications))
          ],
        ),

        body:


        StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection("Medicine").snapshots(),
          builder:(context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount:snapshot.data!.docs.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    QueryDocumentSnapshot document= snapshot.data!.docs[index];
                    return  auth.currentUser!.uid==document["uid"]?

                        Column(
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child:ListTile(
                                title: Row(
                                  children: [
                                    Text("Patient Name: ", style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:FontWeight.bold,
                                        color: Colors.black54)),
                                    Text(document["patientName"]!,style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:FontWeight.bold,
                                        color: Colors.black54),),
                                  ],
                                ),),
                            ),

                            SizedBox(height: 15,),

                            ListView.builder(

                              primary: false,
                                shrinkWrap: true,

                                itemCount:document["medicineDetails"].length ,
                                itemBuilder: (context, index){

                                  var data = document["medicineDetails"][index];
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text("Medicine Name: ", style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:FontWeight.bold,
                                              color: Colors.black54)),

                                          Text(data["medicineName"]!,style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:FontWeight.bold,
                                              color: Colors.black54),),
                                        ],
                                      ),),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text("Eating Time: ", style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:FontWeight.bold,
                                              color: Colors.black54)),

                                          Text(data["eating"]!,style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:FontWeight.bold,
                                              color: Colors.black54),),
                                        ],
                                      ),),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text("Quantity: ", style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:FontWeight.bold,
                                              color: Colors.black54)),

                                          Text(data["qty"]!,style: TextStyle(
                                              fontSize: 18,
                                              fontWeight:FontWeight.bold,
                                              color: Colors.black54),),
                                        ],
                                      ),),
                                  ),
                                  SizedBox(height: 15,),
                                ],
                              );
                            })
                          ],
                        )

                        :Container();
                  });
            }
            else{
              return Center(child: CircularProgressIndicator());
            }

            // ListView.builder(
            //   itemCount:
            //   primary: false,
            //   shrinkWrap: true,
            //   itemBuilder: (context,index){
            //     QueryDocumentSnapshot document=snapshot.data!.docs[index];
            //     return  auth.currentUser!.uid==document["uid"]? DrawerWidget(
            //       imageurl: document["photo"],
            //       name: document["name"],
            //     ):Container();
            //   });
          },
        ),
        // Center(
        //   child: Text("No Data!"),
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddMedicine()),);
          },
          tooltip: 'Add Dose',
          child: const Icon(Icons.add),
        ),
      ),
    );


  }
}