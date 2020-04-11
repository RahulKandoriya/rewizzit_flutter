import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCard/addCard-screen.dart';
import 'package:rewizzit/screens/allRevisionCards/all-revision-cards-screen.dart';
import 'package:rewizzit/screens/bookmark/bookmark-screen.dart';
import 'package:rewizzit/screens/collections/collections-screen.dart';
import 'package:rewizzit/screens/dailyCards/daily-cards-screen.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';
import 'package:rewizzit/screens/nodesPage/nodes-screen.dart';
import 'package:rewizzit/screens/recentCards/recent-cards-screen.dart';
import 'package:rewizzit/screens/recentCardNodes/recent-card-nodes-screen.dart';
import 'package:rewizzit/screens/revisionCards/revision-cards-screen.dart';
import 'package:rewizzit/screens/search_screen/search-screen.dart';
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

  SharedPreferences get prefs => widget.preference;

  TabController controller;

  DiscoverBloc _discoverBloc;


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
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchScreen()));
                },
              ),
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {

                  _navigateAndAddCard(context);
                },
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate(
              [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RevisionCardsScreen(repository: _repository, cardPosition: 0, prefs: prefs,)));
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      color: Colors.yellow,
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
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text("Today's\nRevision",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold, height: 1.3),
                                ),
                              ),
                            )
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: FlareActor("assets/images/revision.flr",
                                  alignment:Alignment.center,
                                  fit:BoxFit.fitHeight, animation:"Untitled"),
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DailyCardsScreen(repository: _repository, prefs: prefs,)));
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      color: Colors.pink,
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

                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            width: 150,
                            height: 150,
                            child: FlareActor("assets/images/loading.flr", alignment:Alignment.center, fit:BoxFit.fitHeight, animation:"roll"),
                          ),
                        ),

                        Spacer(),
                        Center(
                            child: Padding(
                              padding: EdgeInsets.only(right: 40),
                              child: Text("Daily\nCards",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold, height: 1.3),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                        ),

                      ],

                    ),
                  ),
                ),
                BlocBuilder<DiscoverBloc, DiscoverState>(
                  builder: (context, state) {
                    if (state is Failure) {
                      return new Container(
                        height: 300,
                        width: double.infinity,
                        child: Center(
                          child: Text('Failed to Fetch Data'),
                        ),
                      );
                    }
                    if (state is Loaded) {
                      if (state.toString() == null) {
                        return new Container(
                          height: 300,
                          width: double.infinity,
                          child: Center(
                            child: Text('No Data'),
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
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

                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RecentCardsScreen(repository: _repository, cardPosition: 0, prefs: prefs,)));

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
                                  child: state.recentCards.isEmpty
                                  ? Center(
                                    child: Text(
                                      "No Recent Cards"
                                    ),
                                  )
                                  : ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: state.recentCards.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(left: 20, bottom: 15),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RecentCardsScreen(repository: _repository, prefs: prefs, cardPosition: index,)));

                                                    },
                                                    behavior: HitTestBehavior.translucent,
                                                    child: Container(
                                                      height: 230,
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
                                                      child: Text('${state.recentCards[index].content}',
                                                        style: GoogleFonts.amaranth(
                                                          textStyle: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 150,
                                                  margin: EdgeInsets.only(left: 22),
                                                  child: Text('${state.recentCards[index].parentNode.title}',
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal,),
                                                    ),
                                                  ),
                                                )

                                              ],
                                            );
                                          }
                                      ),
                                      SizedBox(width: 20,)

                                    ],
                                  ),
                                ),

                                SizedBox(height: 10,),

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
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RecentCardNodesScreen(repository: _repository, prefs: prefs,)));
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
                                    child: state.cardNodes.isEmpty
                                        ? Center(
                                      child: Text(
                                          "No Recent Card Nodes"
                                      ),
                                    )
                                        : ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: state.cardNodes.length,
                                          itemBuilder: (context, position){
                                            return Container(
                                              margin: EdgeInsets.only(left: 20, bottom: 15),
                                              child: GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, parentNodeId: state.cardNodes[position].sId, prefs: prefs, isFromNodePage: false,)));

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
                                                    gradient: new LinearGradient(
                                                        colors: [Colors.lightBlue, Colors.lightBlue[200]],
                                                        begin: Alignment.topRight,
                                                        end: Alignment.topLeft
                                                    ),
                                                    borderRadius: new BorderRadius.circular(10.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Center(
                                                            child: Padding(
                                                              padding: EdgeInsets.only(left: 20),
                                                              child : Text('${state.cardNodes[position].title}',
                                                                style: GoogleFonts.josefinSans(
                                                                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                                                ),
                                                              ),
                                                            )
                                                        ),
                                                      ),
                                                      SizedBox(width: 15,),
                                                      Center(
                                                        child: Icon(
                                                          Icons.book,
                                                          size: 50,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(width: 30),
                                                    ],

                                                  ),
                                                ),
                                              ),
                                            );
                                          },

                                        ),
                                        SizedBox(width: 20),
                                      ],
                                    )
                                ),
                              ],
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
                                    Text("Collections",
                                      style: GoogleFonts.josefinSans(
                                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CollectionsScreen(repository: _repository, prefs: prefs,)));
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
                                  child: state.topNodes.isEmpty
                                  ? Center(
                                    child: Text(
                                      "No Collections"
                                    ),
                                  )
                                  : ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: state.topNodes.length,
                                        itemBuilder: (context, position){
                                          return Container(
                                            margin: EdgeInsets.only(left : 20, bottom: 15),
                                            child: GestureDetector(
                                              onTap: (){
                                                if(state.topNodes[position].isCardNode){
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, parentNodeId: state.topNodes[position].sId, prefs: prefs, isFromNodePage: false,)));

                                                } else {
                                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository, parentNodeId: "?id=" + state.topNodes[position].sId, prefs: prefs,)));
                                                }
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
                                                  gradient: state.topNodes[position].isCardNode
                                                      ? new LinearGradient(
                                                      colors: [Colors.lightBlue, Colors.lightBlue[200]],
                                                      begin: Alignment.topRight,
                                                      end: Alignment.topLeft
                                                  )
                                                      : new LinearGradient(
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
                                                    Expanded(
                                                      child: Center(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 20),
                                                            child : Text('${state.topNodes[position].title}',
                                                              style: GoogleFonts.josefinSans(
                                                                textStyle: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal),
                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                    SizedBox(width: 15,),
                                                    Center(
                                                      child: Icon(
                                                        state.topNodes[position].isCardNode ? Icons.book : Icons.collections_bookmark,
                                                        size: 50,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(width: 30),
                                                  ],

                                                ),
                                              ),
                                            ),
                                          );
                                        },

                                      ),
                                      SizedBox(width: 20),
                                    ],
                                  )
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

                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BookmarkScreen(repository: _repository, prefs: prefs, cardPosition: 0,)));
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
                                  child: state.bookmarkCards.isEmpty
                                  ? Center(
                                      child: Text(
                                          "No Bookmarked Cards"
                                    ),
                                  )
                                  : ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: state.bookmarkCards.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(left: 20, bottom: 15),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BookmarkScreen(repository: _repository, prefs: prefs, cardPosition: index,)));
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
                                                      child: Text('${state.bookmarkCards[index].content}',
                                                        style: GoogleFonts.amaranth(
                                                          textStyle: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 22),
                                                  child: Text('${state.bookmarkCards[index].parentNode.title}',
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.normal,),
                                                    ),
                                                  ),
                                                )

                                              ],
                                            );
                                          }
                                      ),
                                      SizedBox(width: 20,)
                                    ],
                                  )
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
                                    Text("Revision Cards",
                                      style: GoogleFonts.josefinSans(
                                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: (){

                                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AllRevisionCardsScreen(repository: _repository, cardPosition: 0, prefs: prefs,)));
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
                                  child: state.revisionCards.isEmpty
                                  ? Center(
                                    child: Text(
                                      "No Revision Cards"
                                    ),
                                  )
                                  : ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: state.revisionCards.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(left: 20, bottom: 15),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AllRevisionCardsScreen(repository: _repository,prefs: prefs, cardPosition: index)));
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
                                                      child: Text('${state.revisionCards[index].revisionCard.content}',
                                                        style: GoogleFonts.amaranth(
                                                          textStyle: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w400),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 22),
                                                  child: Text('${state.revisionCards[index].revisionCard.parentNode.title}',
                                                    style: GoogleFonts.josefinSans(
                                                      textStyle: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.normal,),
                                                    ),
                                                  ),
                                                )

                                              ],
                                            );
                                          }
                                      ),
                                      SizedBox(width: 20),
                                    ],
                                  )
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    if(state is Loading){
                      return new Container(
                        height: 300,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return new Container(
                      height: 300,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 150,)
              ],
            )
          /// Set childCount to limit no.of items
          /// childCount: 100,
        ),

      ],
    );
  }

  _navigateAndAddCard(BuildContext context) async {

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddCardScreen(repository: _repository, prefs: prefs,))).then((value){
      setState(() {
        _discoverBloc = BlocProvider.of<DiscoverBloc>(context);
        _discoverBloc.add(Fetch());
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}


