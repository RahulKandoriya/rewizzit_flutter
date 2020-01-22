import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCard/addCard-screen.dart';
import 'package:rewizzit/screens/bookmark/bookmark-screen.dart';
import 'package:rewizzit/screens/collections/collections-screen.dart';
import 'package:rewizzit/screens/dailyCards/daily-cards-screen.dart';
import 'package:rewizzit/screens/nodesPage/nodes-screen.dart';
import 'package:rewizzit/screens/recentCards/recent-cards-screen.dart';
import 'package:rewizzit/screens/recentNodes/recent-nodes-screen.dart';
import 'package:rewizzit/screens/tabs/discover/discover.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverPage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences preference;

  DiscoverPage({Key key, @required Repository repository, @required this.preference})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with SingleTickerProviderStateMixin {

  Repository get _repository => widget._repository;

  SharedPreferences get preference => widget.preference;

  TabController controller;


  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {


    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.grey[200],
          expandedHeight: 80.0,
          flexibleSpace: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 200,
                child: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 20.0, bottom: 15.0),
                    title: Text("Explore",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddCardScreen(repository: _repository)));
                },
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
        BlocBuilder<DiscoverBloc, DiscoverState>(
          builder: (context, state) {
            if (state is Failure) {
              return Center(
                child: Text('Failed to fetch Data'),
              );
            }
            if (state is Loaded) {
              if (state.bookmarkCards.isEmpty) {
                return Center(
                  child: Text('There is no data'),
                );
              }
              return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DailyCardsScreen(repository: _repository)));
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: new BoxDecoration(
                            color: Colors.purple,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[350],
                                blurRadius: 8.0, // has the effect of softening the shadow
                                spreadRadius: 3.0, // has the effect of extending the shadow
                                offset: Offset(
                                  3.0, // horizontal, move right 10
                                  3.0, // vertical, move down 10
                                ),
                              )
                            ],
                            gradient: new LinearGradient(
                                colors: [Colors.purple, Colors.lightBlue[200]],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                            ),
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          height: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Text("Daily\nCards",
                                      style: GoogleFonts.josefinSans(
                                        textStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, height: 1.3),
                                      ),
                                    ),
                                  )
                              ),
                              Spacer(),
                              Center(
                                child: Icon(
                                  Icons.description,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 30),
                            ],

                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text("Recently Added",
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: (){

                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RecentCardsScreen(repository: _repository)));

                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Chip(
                                        backgroundColor: Colors.grey[300],
                                        label: Text("See all",
                                          style: GoogleFonts.josefinSans(
                                            textStyle: TextStyle(fontSize: 15, color: Colors.grey[700], fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),

                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 20, bottom: 15),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RecentCardsScreen(repository: _repository)));

                                            },
                                            behavior: HitTestBehavior.translucent,
                                            child: Container(
                                              height: 250,
                                              margin: const EdgeInsets.only(top: 10),
                                              padding: EdgeInsets.all(10),
                                              width: 156,
                                              decoration: new BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey[350],
                                                    blurRadius: 8.0, // has the effect of softening the shadow
                                                    spreadRadius: 3.0, // has the effect of extending the shadow
                                                    offset: Offset(
                                                      3.0, // horizontal, move right 10
                                                      3.0, // vertical, move down 10
                                                    ),
                                                  )
                                                ],
                                                borderRadius: new BorderRadius.circular(10.0),                        ),
                                              child: Text("The lion is a species in the family Felidae; it is a muscular, deep-chested cat with a short, rounded head. Lion is known as king because of his lifestyle of being highly social",
                                                style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 22),
                                          child: Text("Lion Card",
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal,),
                                            ),
                                          ),
                                        )

                                      ],
                                    );
                                  }
                              ),
                            ),
                            SizedBox(height: 20,),

                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text("Collections",
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CollectionsScreen(repository: _repository)));
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Chip(
                                        backgroundColor: Colors.grey[300],
                                        label: Text("See all",
                                          style: GoogleFonts.josefinSans(
                                            textStyle: TextStyle(fontSize: 15, color: Colors.grey[700], fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),

                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: 200,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  SizedBox(width: 20),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));
                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,
                                        decoration: new BoxDecoration(
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          gradient: new LinearGradient(
                                              colors: [Colors.red, Colors.pink],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("History",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.history,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));

                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,

                                        decoration: new BoxDecoration(
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          gradient: new LinearGradient(
                                              colors: [Colors.green, Colors.lightGreen[200]],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("Finance",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.monetization_on,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));

                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,
                                        decoration: new BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          color: Colors.purple,
                                          gradient: new LinearGradient(
                                              colors: [Colors.yellow, Colors.yellow[500]],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("Maths",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.category,
                                                size: 50,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));

                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,
                                        decoration: new BoxDecoration(
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          gradient: new LinearGradient(
                                              colors: [Colors.brown, Colors.brown[200]],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("Geography",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.nature,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));

                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,
                                        decoration: new BoxDecoration(
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          gradient: new LinearGradient(
                                              colors: [Colors.deepOrange, Colors.orange[200]],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("Politics",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.poll,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text("Bookmarked Cards",
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: (){

                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BookmarkScreen(repository: _repository)));
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Chip(
                                        backgroundColor: Colors.grey[300],
                                        label: Text("See all",
                                          style: GoogleFonts.josefinSans(
                                            textStyle: TextStyle(fontSize: 15, color: Colors.grey[700], fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),

                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: 250,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 20, bottom: 15),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BookmarkScreen(repository: _repository)));
                                            },
                                            behavior: HitTestBehavior.translucent,
                                            child: Container(
                                              height: 200,
                                              margin: const EdgeInsets.only(top: 10),
                                              padding: EdgeInsets.all(10),
                                              width: 124,
                                              decoration: new BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey[350],
                                                    blurRadius: 8.0, // has the effect of softening the shadow
                                                    spreadRadius: 3.0, // has the effect of extending the shadow
                                                    offset: Offset(
                                                      3.0, // horizontal, move right 10
                                                      3.0, // vertical, move down 10
                                                    ),
                                                  )
                                                ],
                                                borderRadius: new BorderRadius.circular(10.0),                        ),
                                              child: Text("The tiger (Panthera tigris) is the largest species among the Felidae and classified in the genus Panthera.",
                                                style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 22),
                                          child: Text("Tiger Card",
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal,),
                                            ),
                                          ),
                                        )

                                      ],
                                    );
                                  }
                              ),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text("Recent Card Nodes",
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RecentNodesScreen(repository: _repository)));
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Chip(
                                        backgroundColor: Colors.grey[300],
                                        label: Text("See all",
                                          style: GoogleFonts.josefinSans(
                                            textStyle: TextStyle(fontSize: 15, color: Colors.grey[700], fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),

                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  SizedBox(width: 20),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));

                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,
                                        decoration: new BoxDecoration(
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          gradient: new LinearGradient(
                                              colors: [Colors.brown, Colors.brown[200]],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("World\nGeography",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.nature,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));

                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,
                                        decoration: new BoxDecoration(
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          gradient: new LinearGradient(
                                              colors: [Colors.deepOrange, Colors.orange[200]],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("Indian\nPolity",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.poll,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));
                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,
                                        decoration: new BoxDecoration(
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          gradient: new LinearGradient(
                                              colors: [Colors.red, Colors.pink],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("History of\nWorld",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.history,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));

                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,
                                        decoration: new BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          color: Colors.purple,
                                          gradient: new LinearGradient(
                                              colors: [Colors.yellow, Colors.yellow[500]],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("Art and\nCulture",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.category,
                                                size: 50,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 15, bottom: 15),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));

                                      },
                                      behavior: HitTestBehavior.translucent,
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 247,

                                        decoration: new BoxDecoration(
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[350],
                                              blurRadius: 8.0, // has the effect of softening the shadow
                                              spreadRadius: 3.0, // has the effect of extending the shadow
                                              offset: Offset(
                                                3.0, // horizontal, move right 10
                                                3.0, // vertical, move down 10
                                              ),
                                            )
                                          ],
                                          gradient: new LinearGradient(
                                              colors: [Colors.green, Colors.lightGreen[200]],
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft
                                          ),
                                          borderRadius: new BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 20),
                                                  child: Text("Finance of\nIndia",
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Spacer(),
                                            Center(
                                              child: Icon(
                                                Icons.monetization_on,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                          ],

                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 150,)
                    ],
                  )
                /// Set childCount to limit no.of items
                /// childCount: 100,
              );
            }
            return SliverFillRemaining(
              child: new Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}


