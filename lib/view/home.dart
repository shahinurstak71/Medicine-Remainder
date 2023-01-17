import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:medicineremainder/notification/cancel_notification.dart';
import 'package:medicineremainder/view/addmedicine.dart';
import '../widget/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdvancedDrawerController _drawerController = AdvancedDrawerController();
  List<String> getDatalist = [];

  FirebaseAuth auth = FirebaseAuth.instance;

  // Future getUserData()async{
  //   await FirebaseFirestore.instance.collection("user").get().then((value){
  //     value.docs.forEach((element){
  //       getDatalist.add(element.reference.id);
  //     });
  //     setState(() {
  //     });
  //   });
  // }
  var now = new DateTime.now();
  var formatter = new DateFormat().add_jm();

  String datetime = DateTime.now().toString();
// String ? dateTime;
String ? name;
String ? image;
String ? eating;
String ? qty;


  getData() async {
    await FirebaseFirestore.instance.collection("Medicine").get().then((value) {
      value.docs.forEach((element) {

        element.data().forEach((key, value) {
          print("value111${value}");
         // list.add(value);
          for(var data in value){
            print("dataaaaaaa${data['time']}");

            if(DateFormat().add_jm().format(DateTime.now())==data["time"]){


              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage:
                              NetworkImage("${element['image']}"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Patient Name : ${element['patientName']}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Medicine Name : ${data['medicineName']}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Eating Time : ${data['eating']}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Quantity : ${data['qty']}"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Accept")),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      cancelNotification().then((value) {
                                        Navigator.pop(context,true);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    CancelNotification()));
                                      });
                                    },
                                    child: Text("Cancel")),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
              image = element["image"];
              name = data["medicineName"];
              eating = data["eating"];
              qty = data["qty"];
              setState(() {

              });
            }

          }


          // list.add(value);
          // //list.elementAt(value);
          // list.forEach((element) {
          //   if(DateFormat().add_jm().format(DateTime.now())== element['time']){
          //     showDialog(context: context, builder: (_){
          //       return AlertDialog(
          //         content: SingleChildScrollView(
          //           child: Column(
          //             children: [
          //               Text("OK")
          //             ],
          //           ),
          //         ),
          //       );
          //     });
          //
          //   }
          // });

        });






      });
    });

  }


@override
  void initState() {
    setState(() {
      getData();
    });
    super.initState();
  }
  @override
  void didUpdateWidget(covariant HomePage oldWidget) {

   setState(() {
     getData();
   });
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
 // getData();
    return AdvancedDrawer(
      backdropColor: Colors.indigoAccent,
      controller: _drawerController,
      animationDuration: Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
      animateChildDecoration: true,
      rtlOpening: false,
      drawer:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("user").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot document = snapshot.data!.docs[index];
                  return auth.currentUser!.uid == document["id"]
                      ? DrawerWidget(
                          imageurl: document["photo"],
                          name: document["name"],
                          email: document["email"],
                        )
                      : Container();
                });
          } else {
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
            onPressed: () {
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CancelNotification()));
                },
                icon: Icon(Icons.notifications))
          ],
        ),

        body:
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Medicine").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot document = snapshot.data!.docs[index];

                    return auth.currentUser!.uid == document["uid"]
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 11,
                              // decoration: BoxDecoration(
                              //
                              //     borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  document["image"] == null
                                      ? Container()
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.blueAccent,
                                          backgroundImage:
                                              NetworkImage(document["image"]),
                                        ),
                                  Container(
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text("Patient Name: ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          Text(
                                            document["patientName"]!,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount:
                                          document["medicineDetails"].length,
                                      itemBuilder: (context, index) {
                                        var data =
                                            document["medicineDetails"][index];
                                        return     Column(
                                          children: [
                                            Container(
                                              child: ListTile(
                                                title: Row(
                                                  children: [
                                                    Text("Medicine Name: ",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color: Colors
                                                                .black54)),
                                                    Text(
                                                      data["medicineName"]!,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              child: ListTile(
                                                title: Row(
                                                  children: [
                                                    Text("Eating Time: ",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color: Colors
                                                                .black54)),
                                                    Text(
                                                      data["eating"]!,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              child: ListTile(
                                                title: Row(
                                                  children: [
                                                    Text("Quantity: ",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color: Colors
                                                                .black54)),
                                                    Text(
                                                      data["qty"]!,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        );
                                        //print("DATE___${DateFormat().add_jm().format(DateTime.now())}");
                                      //   if(DateFormat().add_jm().format(DateTime.now())== data["time"]){
                                      //     return Column(
                                      //       children: [
                                      //         Container(
                                      //           child: ListTile(
                                      //             title: Row(
                                      //               children: [
                                      //                 Text("Medicine Name: ",
                                      //                     style: TextStyle(
                                      //                         fontSize: 18,
                                      //                         fontWeight:
                                      //                         FontWeight.bold,
                                      //                         color: Colors
                                      //                             .black54)),
                                      //                 Text(
                                      //                   data["medicineName"]!,
                                      //                   style: TextStyle(
                                      //                       fontSize: 18,
                                      //                       fontWeight:
                                      //                       FontWeight.bold,
                                      //                       color:
                                      //                       Colors.black54),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 15,
                                      //         ),
                                      //         Container(
                                      //           child: ListTile(
                                      //             title: Row(
                                      //               children: [
                                      //                 Text("Eating Time: ",
                                      //                     style: TextStyle(
                                      //                         fontSize: 18,
                                      //                         fontWeight:
                                      //                         FontWeight.bold,
                                      //                         color: Colors
                                      //                             .black54)),
                                      //                 Text(
                                      //                   data["eating"]!,
                                      //                   style: TextStyle(
                                      //                       fontSize: 18,
                                      //                       fontWeight:
                                      //                       FontWeight.bold,
                                      //                       color:
                                      //                       Colors.black54),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 15,
                                      //         ),
                                      //         Container(
                                      //           child: ListTile(
                                      //             title: Row(
                                      //               children: [
                                      //                 Text("Quantity: ",
                                      //                     style: TextStyle(
                                      //                         fontSize: 18,
                                      //                         fontWeight:
                                      //                         FontWeight.bold,
                                      //                         color: Colors
                                      //                             .black54)),
                                      //                 Text(
                                      //                   data["qty"]!,
                                      //                   style: TextStyle(
                                      //                       fontSize: 18,
                                      //                       fontWeight:
                                      //                       FontWeight.bold,
                                      //                       color:
                                      //                       Colors.black54),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 15,
                                      //         ),
                                      //       ],
                                      //     );
                                      //   }else{
                                      // return  Container();
                                      //   }

                                        // if( DateFormat().add_jm().format(DateTime.now()) ==data['time']){
                                        //  return Text("Abir");
                                        // }else{
                                        //
                                        // }
                                      }),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  });
            } else {
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddMedicine()),
            );
          },
          tooltip: 'Add Dose',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future cancelNotification() async {
    await FirebaseFirestore.instance.collection("Notification").add({
      "name": "$name",
      "EatingTime": "$eating",
      "quantity": "$qty",
      "photo": "$image",
      // "occopation" : workControllar.text
    });
  }
}
