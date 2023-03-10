import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'model/dynamicText.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
   var medicineName = <TextEditingController>[];
   var eatingFood = <TextEditingController>[];
   var qty = <TextEditingController>[];
  TextEditingController patientName =TextEditingController();

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

   var widgets = <Widget>[];
   _onDone() {
     List<DynamicController> entries = [];
     // for (int i = 0; i < widgets.length; i++) {
     //   var name = [i].text;
     //   var age = ageTECs[i].text;
     //   var job = jobTECs[i].text;
     //   entries.add(PersonEntry(name, age, job));
     // }
     Navigator.pop(context, entries);
   }
  addMedicine()async{
    await FirebaseFirestore.instance.collection("Medicine").add(
    {
          "patientName":patientName.text,
    
          "medicineDetails":
          List.generate(widgets.length, (index) => {

            "medicineName" : medicineName[index].text,
            "eating":eatingFood[index].text,
            "qty":qty[index].text,
            "time" : selectedTimeData,

          }),
          "uid":FirebaseAuth.instance.currentUser!.uid,
      "image": imagepath



          // "occopation" : workControllar.text
        }
    );
  }
   DateTime selectedDate = DateTime.now();
   TimeOfDay selectedTime = TimeOfDay.now();
   String selectedTimeData= "";
   DateTime dateTime = DateTime.now();
   bool showDate = false;
   bool showTime = false;
   bool showDateTime = false;
   Future<TimeOfDay> _selectTime(BuildContext context) async {
     final selected = await showTimePicker(
       context: context,
       initialTime: selectedTime,
     );
     if (selected != null && selected != selectedTime) {
       setState(() {
        selectedTimeData =  '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
       //  selectedTime = selected;


         print("SElected Time__$selectedTimeData");
       });
     }
     return selectedTime;
   }
   Future<DateTime> _selectDate(BuildContext context) async {
     final selected = await showDatePicker(
       context: context,
       initialDate: selectedDate,
       firstDate: DateTime(2000),
       lastDate: DateTime(2025),
     );
     if (selected != null && selected != selectedDate) {
       setState(() {
         selectedDate = selected;
       });
     }
     return selectedDate;
   }

   Future _selectDateTime(BuildContext context) async {
     final date = await _selectDate(context);
     if (date == null) return;

     final time = await _selectTime(context);

     if (time == null) return;
     setState(() {
       dateTime = DateTime(
         date.year,
         date.month,
         date.day,
         time.hour,
         time.minute,
       );

     // FlutterAlarmClock.createAlarm(dateTime.hour, dateTime.minute);
     });
   }


  @override
  void initState() {
    // TODO: implement initState
    widgets.add(TextForm());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD MEDICINE"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 8, bottom: 8, right: 8),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
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
                  height: 10,
                ),
                TextFormField(
                  controller: patientName,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    hintText: "Enter patient name",
                    labelText: "Patient name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter patient name';
                    }
                    return null;
                  },
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widgets[index];
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      ElevatedButton(
                          onPressed: () => setState(() => widgets.add(TextForm())), child: Text("More Medicine")),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: Text("Cencel")),
                      Spacer(),
                      TextButton(onPressed: () {
                        int i =0;

                        addMedicine();

                        widgets.forEach((element) {

                          medicineName[i].text = "";
                          eatingFood[i].text="";
                          qty[i].text="";
                          setState(() {
                            i++;
                          });

                        });

                        Fluttertoast.showToast(
                            msg: "Medicine Save SuccessFully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );

                      }, child: Text("Save")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget TextForm(){
    var medicineName1 = TextEditingController();
    var eatingFood1 = TextEditingController();
    var qty1 = TextEditingController();
    medicineName.add(medicineName1);
    eatingFood.add(eatingFood1);
    qty.add(qty1);
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: medicineName1,
          onChanged: (v){
           // print(controller.medicineName);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            hintText: "Enter medicine name",
            labelText: "Medicine Name",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Madicine name';
            }
            return null;
          },
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: eatingFood1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            hintText: "Enter eating food: before/after",
            labelText: "Eating Food",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Eating food';
            }
            return null;
          },
        ),

        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: qty1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            hintText: "Enter dose quantity",
            labelText: "Quantity",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter dose quantity';
            }
            return null;
          },
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
            onPressed: () async {

              final initialTime =
              TimeOfDay(hour: 9, minute: 0);
              final newTime = await showTimePicker(
                  context: context,
                  initialTime: initialTime);

              if (newTime == null) return;
              print(newTime);
              var df = DateFormat("h:mma");
              var dt = df.parse(newTime
                  .format(context)
                  .replaceAll(" ", ""));


              setState(() {
                selectedTimeData =
                    DateFormat().add_jm()
                        .format(dt);
              });



            }, child: Text("Set Alarm")),


      ],
    );
  }
}
