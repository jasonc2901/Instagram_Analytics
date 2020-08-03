import 'package:flutter/material.dart';
import 'package:instagram_analytics_app/view/user_dashboard.dart';

class ViewUsers extends StatefulWidget {
  final List<String> users;
  final String pageTitle;

  const ViewUsers(this.users, this.pageTitle);

  @override
  _ViewUsersPageState createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 5.0,
          title: Text(widget.pageTitle,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          backgroundColor: Color(0xFF333333),
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })),
      backgroundColor: Color(0xFF333333),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widget.users.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 350,
                  color: Colors.grey[600],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      '@${widget.users[index]}',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                )
              ],
            );
          }),
    );
  }
}
