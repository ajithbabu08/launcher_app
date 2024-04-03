// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'main.dart';

// class MyHomePageState extends State<MyHomePage> {

//   @override
//   void initState() {
//     super.initState();
//     getApplications();
//   }

//   List<Application> applications = [];
//   void getApplications() async {
//     final apps = await DeviceApps.getInstalledApplications(
//       includeAppIcons: true,
//       includeSystemApps: true,
//       onlyAppsWithLaunchIntent: true,
//     );
//     setState(() {
//       applications = apps;
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body:
//       ListView.builder(
//         itemCount: applications.length,
//         itemBuilder: (context, index) {
//           final application= applications[index] as ApplicationWithIcon;
//           return ListTile(
//             title: Text(application.appName),
//             leading: Image.memory(application.icon),
//             onTap: (){
//               DeviceApps.openApp(application.packageName);
//             },
//           );
//         },),
//     );
//   }
// }