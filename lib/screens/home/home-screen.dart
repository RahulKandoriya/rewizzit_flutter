import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/firebase_notification_handler.dart';
import 'package:rewizzit/screens/tabs/account/account-screen.dart';
import 'package:rewizzit/screens/tabs/discover/discover.dart';
import 'package:rewizzit/screens/tabs/revision/revision-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  final SharedPreferences preferences;

  final FirebaseAnalyticsObserver observer;

  HomeScreen({Key key, @required this.preferences, @required this.observer})
      : super(key: key);

  static const String routeName = '/tab';

  @override
  HomeScreenState createState() => HomeScreenState(observer);
}

// SingleTickerProviderStateMixin is used for animation
class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, RouteAware  {
  TabController controller;

  int selectedIndex = 0;

  final FirebaseAnalyticsObserver observer;


  HomeScreenState(this.observer);

  SharedPreferences get preference => widget.preferences;

  @override
  void initState() {
    super.initState();

    new FirebaseNotifications().setUpFirebase();
    // Initialize the Tab Controller
    controller = TabController(
        length: 3,
        vsync: this

    );
    controller.addListener(() {
      setState(() {
        if (selectedIndex != controller.index) {
          selectedIndex = controller.index;
          _sendCurrentTabToAnalytics();
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    observer.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    observer.unsubscribe(this);
    controller.dispose();
    super.dispose();
  }

  @override
  void didPush() {
    _sendCurrentTabToAnalytics();
  }

  @override
  void didPopNext() {
    _sendCurrentTabToAnalytics();
  }

  void _sendCurrentTabToAnalytics() {
    observer.analytics.setCurrentScreen(
      screenName: '${HomeScreen.routeName}/tab$selectedIndex',
    );
  }


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          TabBarView(
            // Add tabs as widgets
            children: <Widget>[
              DiscoverScreen(preferences: preference),
              RevisionScreen(preferences: preference),
              AccountScreen(preferences: preference),
            ],
            // set the controller
            controller: controller,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              // set the color of the bottom navigation bar
              // set the tab bar as the child of bottom navigation bar
              color: Colors.grey[300],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))),
              child: TabBar(
                labelColor: Colors.deepPurple,
                unselectedLabelColor: Colors.black54,
                labelStyle:  GoogleFonts.josefinSans(
                  textStyle: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                tabs: <Tab>[
                  Tab(
                    // set icon to the tab
                    icon: Icon(Icons.explore),
                    text: "Explore",
                  ),
                  Tab(
                    icon: Icon(Icons.loop),
                    text: "Revision",

                  ),
                  Tab(
                    icon: Icon(Icons.account_circle),
                    text: "Me",
                  ),
                ],
                // setup the controller
                controller: controller,
              ),
            ),
          )
        ],
      ),
      // Set the bottom navigation bar
    );
  }
}