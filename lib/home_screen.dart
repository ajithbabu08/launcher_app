import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:launcher_app/main.dart';
import 'package:url_launcher/url_launcher.dart';


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



  // @override
  // void initState() {
  //   super.initState();
  //    getApplications();
  //   Future.delayed(Duration(seconds: 3), () {
  //     showPopUp(context);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // Set up the method channel to handle method calls from native Android code
    platform.setMethodCallHandler((call) async {
      switch (call.method) {
        case "retrieveApplications":
        // Call your method to retrieve applications
          getApplications();
            Future.delayed(Duration(seconds: 3), () {
              showPopUp(context);
            });
          // return null;
        default:
          return null;
      }
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
                    exit(0);
                  },
                  child: Text("Close"),
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
      body: Column(
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
