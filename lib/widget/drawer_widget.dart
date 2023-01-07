import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/feedback/feedback.dart';
import '../view/signin.dart';
class DrawerWidget extends StatelessWidget {
  final String? name;
  final String? imageurl;
  final String? email;

  // final VoidCallback? onTab;
  DrawerWidget({Key? key,
    this.name,
    this.imageurl, this.email}) : super(key: key);
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListView(
        primary: false,
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.indigoAccent
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(imageurl!),
                            maxRadius: 65,
                            minRadius: 45,
                          ),
                          Positioned(
                            top: 80,
                            left: 85,
                            child:  Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white.withOpacity(.5)
                              ),
                              child: Center(
                                child: Icon(Icons.camera_alt,size: 25,),
                              ),

                            ),)
                        ],
                      )
                  ),
                  SizedBox(height: 10,),
                  Text(name!,style: TextStyle(fontSize: 25,
                      fontWeight:FontWeight.bold,
                      color: Colors.black54),),
                  // Text("fayej017fa@gmail.com",style: TextStyle(
                  //     fontSize: 15,
                  //     fontWeight:FontWeight.bold,
                  //     color: Colors.black54),)
                ],

              ),
            ),
          ),
          Divider(height:1,color: Colors.black,),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30)
            ),
            child:ListTile(
              leading: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.indigoAccent.withOpacity(0.5)
                ),
                child: Center(
                  child: Icon(Icons.person,size: 25,),
                ),

              ),
              title: Text(email!,style: TextStyle(
                  fontSize: 15,
                  fontWeight:FontWeight.bold,
                  color: Colors.black54),),),
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30)
            ),
            child:ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBack()));
              },
              leading: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.indigoAccent.withOpacity(0.5)
                ),
                child: Center(
                  child: Icon(Icons.feedback_rounded,size: 25,),
                ),

              ),
              title: Text("Feed Back",style: TextStyle(
                  fontSize: 15,
                  fontWeight:FontWeight.bold,
                  color: Colors.black54),),),
          ),

          SizedBox(height: 15),



          // Container(
          //   decoration: BoxDecoration(
          //       color: Colors.white24,
          //       borderRadius: BorderRadius.circular(30)
          //   ),
          //   child:ListTile(
          //     leading: Container(
          //       height: 45,
          //       width: 45,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(100),
          //           color: Colors.white
          //       ),
          //       child: Center(
          //         child: Icon(Icons.message_rounded,size: 25,),
          //       ),
          //
          //     ),
          //     title: Text("Message Requests ",style: TextStyle(
          //         fontSize: 15,
          //         fontWeight:FontWeight.bold,
          //         color: Colors.black54),),),
          // ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30)
            ),
            child:ListTile(
              leading: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.indigoAccent.withOpacity(0.5)
                ),
                child: Center(
                  child: Icon(Icons.logout,size: 25,),
                ),

              ),
              title: InkWell(
                onTap:(){
                  auth.signOut();

                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);

                },
                child: Text("Log Out",style: TextStyle(
                    fontSize: 15,
                    fontWeight:FontWeight.bold,
                    color: Colors.black54),),
              ),),
          )
        ],
      ),
    );
  }
}
