
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medicineremainder/view/home.dart';
import 'package:medicineremainder/view/signup.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  FirebaseAuth auth=FirebaseAuth.instance;
  bool loder=true;
  bool chackpassword=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                        "https://tse2.mm.bing.net/th?id=OIP.zuB7V4-F4BoOO3LDNzGpIwHaHj&pid=Api&P=0"),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))

                    ),
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                        hintText: "Enter your email",
                        labelText: "Email",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white
                    ),
                    child: TextFormField(
                      obscureText: chackpassword,
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        suffixIcon:InkWell(
                            onTap: (){
                              chackpass();
                            },
                            child:chackpassword ?Icon(Icons.visibility_off):Icon(Icons.visibility)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50))),
                        hintText: "Enter password",
                        labelText: "Password",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: () {
                    login();
                  }, child: Text("SingIn")),
                  SizedBox(
                    height: 10,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (ctx) => AlertDialog(
                  //               title: Text("Select you?"),
                  //               content: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 children: [
                  //                   ElevatedButton(
                  //                       onPressed: () {
                  //                         Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                               builder: (context) => UserSignUp()),
                  //                         );
                  //                       },
                  //                       child: Text("User")),
                  //                   SizedBox(
                  //                     height: 20,
                  //                   ),
                  //                   ElevatedButton(
                  //                       onPressed: () {
                  //                         Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                               builder: (context) => UserSignUp()),
                  //                         );
                  //                       },
                  //                       child: Text("Driver")),
                  //                 ],
                  //               ),
                  //               actions: [
                  //                 TextButton(
                  //                     onPressed: () {
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                     child: Container(
                  //                       child: Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text("Cencel"),
                  //                       ),
                  //                     ))
                  //               ],
                  //             ));
                  //   },
                  //   child: RichText(
                  //     text: TextSpan(
                  //         text: "Don't have an account ? ",
                  //         style: TextStyle(
                  //           color: Colors.red,
                  //         ),
                  //         children: <TextSpan>[
                  //           TextSpan(
                  //               text: 'SingUp',
                  //               style: TextStyle(
                  //                 color: Colors.green,
                  //               ))
                  //         ]),
                  //   ),
                  // )

                  InkWell(
                    onTap: (){

                       Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => UserSignUp()),
                                          );
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'SingUp',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ))
                            ]),
                      ),
                  ),
                ]

              ),
            ),
          ),
        ),
      ),
    );
  }

  Future login() async{
    try{
      setState(() {
        loder=true;
      });
      await auth.signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text);
      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));

    }on FirebaseAuthException catch(e)
    {
      setState(() {
        Fluttertoast.showToast(
            msg: "${e.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        loder=false;
      });
    }


  }

  void chackpass() {
    setState(() {
      chackpassword=!chackpassword;
    });
  }
}