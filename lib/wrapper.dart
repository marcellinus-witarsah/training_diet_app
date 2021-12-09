import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/model/user_model.dart';
import 'package:training_and_diet_app/services/auth.dart';
import 'package:training_and_diet_app/ui/pages/login.dart';
import 'package:training_and_diet_app/ui/pages/profile.dart';
import 'package:training_and_diet_app/ui/pages/profile_screen.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    // _auth = Provider.of<AuthService>(context);
    final AuthService _auth = new AuthService();
    // final _userModel = Provider.of<UserModel?>(context);
    return StreamBuilder<UserModel>(
      stream: _auth.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return new Login();
          } else {
            // return new Homepage();
            return new Homepage();
          }
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
  }
}

// Strea