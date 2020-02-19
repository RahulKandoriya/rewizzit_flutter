import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';
import './bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentCardNodesPage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences prefs;

  RecentCardNodesPage({Key key, @required Repository repository, @required this.prefs})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _RecentCardNodesPageState createState() => _RecentCardNodesPageState();
}

class _RecentCardNodesPageState extends State<RecentCardNodesPage> with SingleTickerProviderStateMixin {

  Repository get _repository => widget._repository;
  SharedPreferences get prefs => widget.prefs;

  var currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              title: Text("Card Nodes",
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: BlocBuilder<RecentCardNodesBloc, RecentCardNodesState>(
              builder: (context, state) {
                if (state is Failure) {
                  return Center(
                    child: Text('failed to fetch Data'),
                  );
                }
                if (state is Loaded) {
                  if (state.cardNodes.isEmpty) {
                    return Center(
                      child: Text('No Nodes'),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: ListView(
                      children: <Widget>[
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: state.cardNodes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){

                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, parentNodeId: state.cardNodes[index].sId, prefs: prefs, isFromNodePage: false,)));
                                },
                                behavior: HitTestBehavior.translucent,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10,),
                                  height: 150,
                                  width: double.infinity,
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
                                      Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text('${state.cardNodes[index].title}',
                                              style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                          )
                                      ),
                                      Spacer(),
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
                              );
                            }),
                        SizedBox(height: 100,)
                      ],
                    ),

                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}




