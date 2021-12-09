import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_and_diet_app/services/auth.dart';
import 'package:training_and_diet_app/services/db.dart';
import 'package:training_and_diet_app/ui/pages/bmiscreen.dart';
import 'package:training_and_diet_app/ui/pages/profile.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _db = DatabaseService();
  final _auth = AuthService();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String _gender = '';

// https://firebase.flutter.dev/docs/firestore/usage
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.user,
      builder: (context, snapshot) {
        // return Text(snapshot.data.uid);
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile Edit page'),
            backgroundColor: Color(0xFF200087),
          ),
          body: Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Height in cm',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Weight in kg',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF200087),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    child: Text('Save Changes'),
                    onPressed: () {
                      Map<String, dynamic> data = {
                        "first_name": _firstNameController.text,
                        "last_name": _lastNameController.text,
                        "height": double.parse(_heightController.text),
                        "weight": double.parse(_weightController.text),
                        "age": int.parse(_ageController.text),
                      };
                      print(data);
                      _db.updateUserCollection(snapshot.data.uid, data);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Profile edit has been saved"),
                      ));
                      Navigator.popAndPushNamed(context, '/realprofile');
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
