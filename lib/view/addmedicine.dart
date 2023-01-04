import 'package:flutter/material.dart';

class AddMedicine extends StatelessWidget {
  const AddMedicine({Key? key}) : super(key: key);

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
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://tse1.mm.bing.net/th?id=OIP.lk0mSZHNt1YOxS_YERXRNwHaEq&pid=Api&P=0"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    hintText: "Enter madicine name",
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
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 35),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: Text("Set Alarm")),
                      SizedBox(
                        width: 60,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: Text("More Medicine")),
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
                      TextButton(onPressed: () {}, child: Text("Save")),
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
}
