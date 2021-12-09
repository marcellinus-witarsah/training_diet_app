import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/services/auth.dart';
import 'package:training_and_diet_app/services/db.dart';
import 'package:training_and_diet_app/ui/pages/login.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _db = DatabaseService();
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final genders = ["Male", "Female"];
  String _gender = "Male";
  @override
  Widget build(BuildContext context) {
    // @override
    // void initState() {
    //   super.initState();
    //   _gender = 'Male';
    // }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF20008B), Colors.black]),
        ),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 60, left: 10),
                        child: RotatedBox(
                            quarterTurns: -1,
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.w900,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: Container(
                          //color: Colors.green,
                          height: 200,
                          width: 200,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 60,
                              ),
                              Center(
                                child: Text(
                                  'Start Your Diet Journey With Us Now !',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 50, right: 50),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              controller: _emailController,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.lightBlueAccent,
                                labelText: 'E-mail',
                                labelStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 50, right: 50),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              controller: _passwordController,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 38, right: 50),
                          child: Container(
                            height: 77,
                            width: MediaQuery.of(context).size.width,
                            child: FormField<String>(
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        "Select Gender",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      value: _gender,
                                      isDense: true,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      selectedItemBuilder:
                                          (BuildContext context) {
                                        return genders.map((String value) {
                                          return Text(
                                            _gender,
                                            style: const TextStyle(
                                                color: Colors.white70),
                                          );
                                        }).toList();
                                      },
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _gender = newValue;
                                        });
                                        print(_gender);
                                      },
                                      items: genders.map((String gender) {
                                        return DropdownMenuItem<String>(
                                          value: gender,
                                          child: Text(
                                            gender,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 50, left: 200),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: TextButton(
                        onPressed: () async {
                          User user = await _authService.register(
                              _emailController.text, _passwordController.text);
                          if (user != null) {
                            // Map<String, dynamic> data = {
                            //   "email": _emailController.text,
                            //   "password": _passwordController.text,
                            //   "gender": _gender
                            // };
                            // _db.addData(user.uid, _db.users, data);
                            Navigator.pop(context);
                          } else {
                            print("Register Failed");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
                    child: Container(
                      alignment: Alignment.topRight,
                      //color: Colors.red,
                      height: 20,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Have we met before?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
