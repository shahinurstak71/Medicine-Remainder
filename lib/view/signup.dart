import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicineremainder/view/signin.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserSignUp extends StatefulWidget {
  UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontrollar = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth=FirebaseAuth.instance;
  bool loder=true;

  File ? imagefile;
  ImagePicker imagePicker = ImagePicker();
  String? imagepath;


  bool chackpassword=true;
  void takePhoto (ImageSource source)async{
    final picarimagefile= await imagePicker.getImage(source:source,imageQuality: 80);
    setState(() {
      imagefile= File(picarimagefile!.path);
    });
    Reference reference=FirebaseStorage.instance.ref().child(DateTime.now().toString());
    await reference.putFile(File(imagefile!.path));
    reference.getDownloadURL().then((value){
      setState(() {
        imagepath=value;
        print("Image Link....${imagepath}");
      });

    });

  }

  // void takePhoto(ImageSource source) async {
  //   final picarimagefile =
  //       await imagePicker.getImage(source: source, imageQuality: 80);
  //   setState(() {
  //     imagefile = File(picarimagefile!.path);
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      imagefile != null
                          ? CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(File(imagefile!.path)),
                            )
                          : CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.blueAccent,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Uplod a Photo"),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                takePhoto(ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Camera")),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                takePhoto(ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Gallery"))
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.camera,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        hintText: "Enter your name",
                        labelText: "Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        hintText: "Enter your email",
                        labelText: "Email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: TextFormField(
                      obscureText: chackpassword,
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        suffixIcon:InkWell(
                            onTap: (){
                              chackpass();
                            },

                            child:chackpassword ? Icon(Icons.visibility_off):Icon(Icons.visibility)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        hintText: "Enter  password",
                        labelText: "Password",
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        hintText: "Enter confirm password",
                        labelText: "Confirm Password",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter confirm password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {

                        if (_formKey.currentState!.validate()) {
                          register();
                        }
                      },
                      child: Text("SingUp")),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Allready have an account ? ",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'SingIn',
                                style: TextStyle(
                                  color: Colors.green,
                                ))
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future register() async{
    try{
      setState(() {
        loder=true;
      });
      await auth.createUserWithEmailAndPassword(
          email: emailcontroller.text.toString(),
          password: passwordcontroller.text.toString()
      );

      addDetels();
      Fluttertoast.showToast(
          msg: "Registration Successful, Please Login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // addDetels();
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignIn()));

    }on FirebaseAuthException catch(e)
    {
      setState(() {
        Fluttertoast.showToast(
            msg: "${e.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        loder=false;
      });
    }}

  Future addDetels()async{

    await FirebaseFirestore.instance.collection("user").add(
        {
          "name" : namecontroller.text,
          "id":auth.currentUser!.uid,
          "email":emailcontroller.text,
          "photo":imagepath ??"",
          // "occopation" : workControllar.text
        }
    );

  }

  void chackpass() {
    setState(() {
      chackpassword=!chackpassword;
    });
  }
}
