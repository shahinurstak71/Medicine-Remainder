
import 'package:flutter/material.dart';
import 'package:medicineremainder/view/home.dart';
import 'package:medicineremainder/view/signup.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  "https://tse2.mm.bing.net/th?id=OIP.zuB7V4-F4BoOO3LDNzGpIwHaHj&pid=Api&P=0"),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  hintText: "Enter your email",
                  labelText: "Email",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  hintText: "Enter password",
                  labelText: "Password",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
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
    );
  }
}