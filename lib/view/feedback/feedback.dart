

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {

  TextEditingController email = TextEditingController();
  TextEditingController feedBack = TextEditingController();
  TextEditingController problem = TextEditingController();
  sendMail()async{
    final Email email = Email(
      body: "Problem:- ${problem.text}\n Description:- ${feedBack.text}",
      subject: 'FeedBack',
      recipients: ['fuadmostafij6@gmail.com'],

      isHTML: false,
    );

    await FlutterEmailSender.send(email).then((value){

    });
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        //backgroundColor: const Color(0xffC4DFCB),
        appBar: AppBar(
          title: Text("FEED BACK"),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              // TextFormField(
              //   controller: email,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(50))),
              //     hintText: "Enter your email",
              //     labelText: "Email",
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter email';
              //     }
              //     return null;
              //   },
              // ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: problem,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: "Enter your Problem",
                    labelText: "Problem Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter problem';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: feedBack,
                  minLines: 2,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: "Enter your description",
                    labelText: "description",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {

                sendMail();


              }, child: Text("SingIn")),
            ],
          ),
        ),
      );
  }
}