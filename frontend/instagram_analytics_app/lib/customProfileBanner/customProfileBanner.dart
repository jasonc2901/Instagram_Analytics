import 'dart:ui';
import 'package:flutter/material.dart';

class CustomProfileBanner extends StatelessWidget {
  final String username, bio;
  final String profilePic;

  CustomProfileBanner(
      {@required this.username,
      @required this.bio,
      @required this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: profileContent(context),
    );
  }

  profileContent(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 350,
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  "@" + username,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                      textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Text(
                  bio,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            top: Consts.paddingtop,
            child: CircleAvatar(
              radius: 60,
              child: ClipOval(
                child: Image.network(
                  profilePic,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double paddingtop = 30.0;
  static const double avatarRadius = 70.0;
}
