import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/services/auth.dart';
import 'package:training_and_diet_app/ui/pages/login.dart';
import 'package:training_and_diet_app/ui/pages/profile.dart';
import 'package:training_and_diet_app/ui/pages/profile_edit.dart';
import 'package:training_and_diet_app/ui/pages/profile_screen.dart';
//import 'package:training_and_diet_app/ui/pages/workout_screen.dart';
import 'package:training_and_diet_app/ui/pages/bmiscreen.dart';
import 'package:training_and_diet_app/ui/pages/recipes_screen.dart';
import 'package:training_and_diet_app/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Wrapper(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/profileScreen': (BuildContext context) => new ProfileScreen(),
        '/bmi': (BuildContext context) => new InputPage(),
        '/recipe': (BuildContext context) => new RecipePage(),
        '/realprofile': (BuildContext context) => new ProfilePage(),
        '/edit': (BuildContext context) => new ProfileEdit(),
      },
    );
  }
}
