import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/services/auth.dart';
import 'package:training_and_diet_app/services/db.dart';
import 'package:training_and_diet_app/ui/bottom_nav_bar.dart';
import 'package:training_and_diet_app/ui/pages/profile_edit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _auth = new AuthService();
    final _db = new DatabaseService();
    return StreamBuilder(
      stream: _auth.user,
      builder: (context, snapshot) {
        return FutureBuilder<DocumentSnapshot>(
          future: _db.getUserData(snapshot.data.uid),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> docSnapshot) {
            if (docSnapshot.hasData) {
              Map<String, dynamic> data =
                  docSnapshot.data.data() as Map<String, dynamic>;
              return Scaffold(
                bottomNavigationBar: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  child: BottomNavBar(3),
                ),
                body: Column(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF20008B),
                            const Color(0xFF200087),
                          ],
                        )),
                        child: Container(
                          width: double.infinity,
                          height: 625.0,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                                  ),
                                  radius: 50.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${data['first_name']} ${data['last_name']}",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.white,
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 22.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Height",
                                                style: TextStyle(
                                                  color: Color(0xFF20008B),
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${data['height'].toString()} cm",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF20008B),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Weight",
                                                style: TextStyle(
                                                  color: Color(0xFF20008B),
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "${data['weight'].toString()} kg",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF20008B),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Age",
                                                style: TextStyle(
                                                  color: Color(0xFF20008B),
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "${data['age'].toString()} ",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF20008B),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Gender",
                                                style: TextStyle(
                                                  color: Color(0xFF20008B),
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "${data['gender']}",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF20008B),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 300.00,
                                  child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/edit');
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0)),
                                      elevation: 0.0,
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 300.0, minHeight: 50.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                color: Color(0xFF20008B),
                                                fontSize: 26.0,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: 300.00,
                      child: RaisedButton(
                          onPressed: () {
                            _auth.logout();
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          elevation: 0.0,
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF20008B),
                                  const Color(0xFF200087),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Log Out",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[CircularProgressIndicator()])),
              );
            }
          },
        );
      },
    );
  }
}
