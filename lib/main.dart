import 'package:flutter/material.dart';
import 'view/pages/HomePage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:developer';

// class FailBallApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fantasy Football',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }
// }


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  log("connecting to firebase ...");
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  log("done");
  runApp(const FailBallApp());
}

class FailBallApp extends StatelessWidget {
  const FailBallApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Failball',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Failball Home Page'),
    );
  }
}

