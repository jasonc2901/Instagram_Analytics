import 'package:instagram_analytics_app/CustomAlert/custom_alert.dart';
import 'package:instagram_analytics_app/customProfileBanner/customProfileBanner.dart';
import 'package:instagram_analytics_app/models/InstaModel.dart';
import 'package:flutter/material.dart';
import 'package:instagram_analytics_app/blocs/InstaBloc.dart';
import 'package:instagram_analytics_app/networking/Response.dart';
import 'package:instagram_analytics_app/view/user_login.dart';
import 'package:instagram_analytics_app/view/view_users.dart';

class UserDashboardPage extends StatefulWidget {
  final String instagramUsername;
  final String instagramPassword;

  const UserDashboardPage(this.instagramUsername, this.instagramPassword);

  @override
  _ShowDashboardPageState createState() => _ShowDashboardPageState();
}

class _ShowDashboardPageState extends State<UserDashboardPage> {
  InstaBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = InstaBloc(widget.instagramUsername, widget.instagramPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 5.0,
            title: Text('Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            backgroundColor: Color(0xFF333333),
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserLoginForm()),
                  );
                })),
        backgroundColor: Color(0xFF333333),
        body: RefreshIndicator(
          onRefresh: () => _bloc.fetchInstaDetails(
              widget.instagramUsername, widget.instagramPassword),
          child: StreamBuilder<Response<InstaModel>>(
            stream: _bloc.instaDataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return InstaDashboard(displayUser: snapshot.data.data);
                    break;
                  case Status.ERROR:
                    String error = snapshot.data.message;
                    String errorDesc = '';

                    if (error.contains("Error occured while Communication with Server with StatusCode : 500")) {
                      error = "Invalid Login!";
                      errorDesc = "Ensure details are correct and try again!";
                    }

                    print("Error Simplified: " + error.toString());
                    return Error(
                      errorMessage: error,
                      errorDescription: errorDesc,
                      onRetryPressed: () => _bloc.fetchInstaDetails(
                          widget.instagramUsername, widget.instagramPassword),
                    );
                    break;
                }
              }
              return Container();
            },
          ),
        ));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class InstaDashboard extends StatelessWidget {
  final InstaModel displayUser;

  const InstaDashboard({Key key, this.displayUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: new Color(0xFF736AB7),
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getContent(context),
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return new Container(
      child: Container(
        decoration: BoxDecoration(color: Color(0xFF333333)),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    return new ListView(
      children: <Widget>[
        CustomProfileBanner(
          username: displayUser.data.username,
          bio: displayUser.data.userBio,
          profilePic: displayUser.data.imgUrl,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Container(
          child: GridView.count(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'followersNotFollowingYouBackBtn',
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Number of followers not following you back: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Text(
                        displayUser.data.followersNotFollowingBack.length
                            .toString(),
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.teal[200]
                  ),
                ),
                onPressed: () => {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewUsers(displayUser.data.followersNotFollowingBack, "Followers not following you back")),
                  )
                },
              ),
              FloatingActionButton(
                heroTag: 'followersYourNotFollowingBackBtn',
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Number of followers you aren't following back: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Text(
                        displayUser.data.followersYouDontFollowBack.length
                            .toString(),
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[600]
                  ),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewUsers(displayUser.data.followersYouDontFollowBack, "Followers you don't follow back")),
                  )
                },
              ),
              FloatingActionButton(
                heroTag: 'TotalPostsBtn',
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Total number of posts: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Text(
                        displayUser.data.numPosts
                            .toString(),
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[600]
                  )
                ),
                onPressed: () => {
                  print("Pressed")
                },
              ),
              FloatingActionButton(
                heroTag: 'NumFollowersBtn',
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Number of Followers: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Text(
                        displayUser.data.numFollowers
                            .toString(),
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.teal[200]
                  ),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewUsers(displayUser.data.followers, "Followers")),
                  )
                },
              ),
              FloatingActionButton(
                heroTag: 'NumFollowingBtn',
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Number Following: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Text(
                        displayUser.data.numFollowing
                            .toString(),
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.teal[200]
                  ),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewUsers(displayUser.data.following, "Following")),
                  )
                },
              ),
              
            ],
          ),
        )
      ],
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  final String errorDescription;
  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.errorDescription, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
          title: errorMessage, 
          description: errorDescription, 
          buttonText: "Retry", 
          alertImage: "assets/x.png", 
          buttonColor: Colors.red[600]
      );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
