import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';




void main() {
  runApp(MaterialApp(home: UserHomeScreen()));
}


class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
 
 
  List<Application> applications = [];

  static const platform = MethodChannel('launcher_settings');



  @override
  void initState() {
    super.initState();
     getApplications();
    Future.delayed(Duration(seconds: 3), () {
      showPopUp(context);
    });
  }



  Future<void> _openLauncherSettings(String launcher) async {
  try {
    await platform.invokeMethod('openSettings', {"launcher": launcher});
  } on PlatformException catch (e) {
    print("Failed to open settings: '${e.message}'.");
  }
}


   void getApplications() async {
    final apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    setState(() {
      applications = apps;
    });
  }

   void showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select launcher"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    
                    print("default launcher button clicked");
                    _openLauncherSettings("Default Launcher");
                    // Navigator.of(context).pop();
                  },
                  child: Text("default launcher"),
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.of(context).popUntil((route) => route.isFirst); 
                    Navigator.of(context).pop(); 
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      //  Container(color: Colors.yellow,)
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: applications.length,
              itemBuilder: (context, index) {
                final application = applications[index] as ApplicationWithIcon;
                return ListTile(
                  title: Text(application.appName),
                  leading: Image.memory(application.icon),
                  onTap: () {
                    DeviceApps.openApp(application.packageName);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}