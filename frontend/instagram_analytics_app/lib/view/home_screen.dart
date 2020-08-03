import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:instagram_analytics_app/view/user_login.dart';

class HomePage extends StatefulWidget {
  @override
  _GetHomeState createState() => _GetHomeState();
}

class _GetHomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title:
              Text('Home', style: TextStyle(color: Colors.white, fontSize: 27)),
          backgroundColor: Color(0xFF333333),
        ),
        backgroundColor: Color(0xFF333333),
        body: Container(
          child: Center(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                "Welcome!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 70, bottom: 100),
                child: Text(
                  "Sign in now to see your Instagram Analytics!",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SignInButtonBuilder(
                text: 'Sign in with Instagram',
                image: Image.asset(
                  'assets/instagram.png',
                  width: 60,
                  height: 50,
                ),
                fontSize: 14,
                backgroundColor: Colors.grey[600],
                height: 70,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserLoginForm()
                      )
                  );
                },
              ),
            ]),
          ),
        ));
  }
}
