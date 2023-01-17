import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CancelNotification extends StatefulWidget {
  const CancelNotification({Key? key}) : super(key: key);

  @override
  State<CancelNotification> createState() => _CancelNotificationState();
}

class _CancelNotificationState extends State<CancelNotification> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Notification"),

      ),
      body:   StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Notification").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot document = snapshot.data!.docs[index];
                  return    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                "${document["photo"]}"
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${document['name']}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${document["EatingTime"]}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${document["quantity"]}"),
                          ),

                        ],
                      ),
                    ),
                  );
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


    );

  }
}
