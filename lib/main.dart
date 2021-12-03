import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training_and_diet_app/ui/pages/login.dart';
import 'package:training_and_diet_app/ui/pages/profile_screen.dart';
import 'package:training_and_diet_app/ui/pages/workout_screen.dart';
import 'package:training_and_diet_app/ui/pages/bmiscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: Login(),
      routes: <String, WidgetBuilder> {
          '/login': (BuildContext context) => new Login(),
          '/profileScreen' : (BuildContext context) => new ProfileScreen(),
          '/bmi' : (BuildContext context) => new InputPage(),
          // '/realprofile' : (BuildContext context) => new Screen4()
        },
    );
  }
}
