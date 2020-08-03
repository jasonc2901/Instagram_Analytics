import 'package:flutter/material.dart';
import 'package:instagram_analytics_app/CustomAlert/custom_alert.dart';
import 'package:instagram_analytics_app/view/home_screen.dart';
import 'package:instagram_analytics_app/view/user_dashboard.dart';

class UserLoginForm extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}


class _UserLoginState extends State<UserLoginForm> {

  final usernameController = TextEditingController(); 
  final passwordController = TextEditingController(); 
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text('User Details',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            backgroundColor: Color(0xFF333333),
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                })),
        backgroundColor: Color(0xFF333333),
        body: Container(
          child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60, left: 10),
              child: Text(
                "Enter Username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, bottom: 20),
              child: new TextFormField(
                controller: usernameController,
                validator: (val) => val.length < 2 ? 'Still too short' : null,
                decoration: new InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.grey,
                  filled: true,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Calibri",
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Text(
                "Enter Password",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10, bottom: 30),
              child: new TextFormField(
                controller: passwordController,
                validator: (val) => val.length < 2 ? 'Still too short' : null,
                decoration: new InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.grey,
                  filled: true,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Calibri",
                  color: Colors.white,
                ),
                obscureText: true,
              ),
            ),
            FloatingActionButton.extended(
                onPressed: () {
                  if (usernameController.text.length > 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            UserDashboardPage(usernameController.text, passwordController.text)));
                  } else {
                    showDialog(
                      context: context,
                      child: new CustomDialog(
                        title: 'Cannot leave field empty!',
                        description: "Please enter a valid username.",
                        buttonText: "Okay",
                        alertImage: "assets/x.png",
                        buttonColor: Colors.red[700],
                      ),
                    );
                  }
                },
                tooltip: 'Show user!',
                backgroundColor: Colors.grey,
                label: Text('Login'),
                icon: Icon(Icons.check_circle),
              ),
            ],
          ),
        )
    );
  }
}
