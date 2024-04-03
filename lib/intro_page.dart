import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';


// void main(){
//   runApp(MaterialApp(home: Select_Launcher()));
// }

class Select_Launcher extends StatefulWidget {
  const Select_Launcher({super.key});

  @override
  State<Select_Launcher> createState() => _Select_LauncherState();
}

class _Select_LauncherState extends State<Select_Launcher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red,minimumSize: Size(120, 60)),
                onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  backgroundColor: Colors.red,
                    content: Text("Launcher Not Available")));
                },
                child: Text("Default launcher",style: TextStyle(color: Colors.white),)),
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green,minimumSize: Size(160,60)),
                onPressed: ()
            {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserHomeScreen()));

            },
                child: Text("My launcher",style: TextStyle(color: Colors.white))),
          )
        ],
      ),
    );
  }
}
