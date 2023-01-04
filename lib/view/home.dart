

import 'package:flutter/material.dart';
import 'package:medicineremainder/view/addmedicine.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      
      appBar: AppBar(
        
        title: Text("Medicine Remainder"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){

            },
             icon: Icon(Icons.feedback))
        ],
      ),
      
      body: Center(
        child: Text("No Data!"),
      ),


        floatingActionButton: FloatingActionButton(
        onPressed: (){
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddMedicine()),
  );
        },
        tooltip: 'Add Dose',
        child: const Icon(Icons.add),
      ),
    );
  }
}