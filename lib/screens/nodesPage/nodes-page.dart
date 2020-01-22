import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addNode/addNode-screen.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';
import 'package:rewizzit/screens/nodesPage/nodes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NodesPage extends StatefulWidget {

  final Repository _repository;

  NodesPage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _NodesPageState createState() => _NodesPageState();
}

class _NodesPageState extends State<NodesPage> with SingleTickerProviderStateMixin {


  Repository get _repository => widget._repository;
  PageController controller = PageController(keepPage: true, viewportFraction: 0.8);
  var currentPageValue = 0.0;
  bool isAppBarUp;

  @override
  void initState() {
    super.initState();
  }


  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: (){

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
                                    child: Text("Node\nTitle",
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
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 25,),
                        Icon(
                          Icons.edit,
                          size: 30,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 25,),
                        Icon(
                          Icons.arrow_upward,
                          size: 30,
                          color: Colors.grey,
                        ),

                      ],
                    ),


                  ],
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  child: BlocBuilder<NodesBloc, NodesState>(
                    builder: (context, state) {
                      if (state is Failure) {
                        return Center(
                          child: Text('failed to fetch posts'),
                        );
                      }
                      if (state is Loaded) {
                        if (state.bookmarkCards.isEmpty) {
                          return Center(
                            child: Text('no posts'),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, i) => Container(
                            margin: EdgeInsets.only(left: 15, bottom: 15),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository)));
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: 200,

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
                                          child: Text("Node\nTitle",
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
                          controller: controller,

                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 100, right: 100, bottom: 50),
                  child: RaisedButton(
                    color: Colors.deepPurple,
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddNodeScreen(repository: _repository)));

                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_circle_outline,
                            size: 25,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text("Add Node",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 30),
              child: Icon(
                  Icons.close
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}




