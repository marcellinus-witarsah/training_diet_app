import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/services/auth.dart';
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
    int _selectedIndex = 3;
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          iconSize: 40,
          selectedIconTheme: IconThemeData(
            color: const Color(0xFF200087),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.black12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.home),
              ),
              title: Text(
                "Home",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.calculate),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              title: Text(
                "BMI Calculator",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.food_bank_rounded),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              title: Text(
                "Food",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.account_circle),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              title: Text(
                "profile",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int _selectedIndex) {
            switch (_selectedIndex) {
              // case 0:
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) {
              //       return ProfileScreen();
              //     }),
              //   );
              //   break;
              case 1:
                Navigator.popAndPushNamed(
                  context,
                  '/bmi',
                );
                break;
              case 2:
                Navigator.popAndPushNamed(
                  context,
                  '/recipe',
                );
                break;
              case 3:
                Navigator.popAndPushNamed(
                  context,
                  '/realprofile',
                );
                break;
              // case 2: test@test.testtest
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) {
              //     return ProfileScreen();
              //   }),
              // );
              // break;
            }
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF20008B), Colors.black])),
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
                        "Alice James",
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
                                      "5200",
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
                                      "28.5K",
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
                                      "1300",
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
                                      "1300",
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEdit()),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            elevation: 0.0,
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
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
          // Container(
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text(
          //           "Bio:",
          //           style: TextStyle(
          //               color: Color(0xFF20008B),
          //               fontStyle: FontStyle.normal,
          //               fontSize: 28.0),
          //         ),
          //         SizedBox(
          //           height: 10.0,
          //         ),
          //         Text(
          //           'My name is Alice and I am  a freelance mobile app developper.\n'
          //           'if you need any mobile app for your company then contact me for more informations',
          //           style: TextStyle(
          //             fontSize: 22.0,
          //             fontStyle: FontStyle.italic,
          //             fontWeight: FontWeight.w300,
          //             color: Colors.black,
          //             letterSpacing: 2.0,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Color(0xFF20008B), Colors.black]),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
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
  }
}
