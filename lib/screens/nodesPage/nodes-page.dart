import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addNode/addNode-screen.dart';
import 'package:rewizzit/screens/editNode/editNode-screen.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';
import 'package:rewizzit/screens/nodesPage/nodes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NodesPage extends StatefulWidget {

  final Repository _repository;
  final String parentNodeId;

  NodesPage({Key key, @required Repository repository, @required this.parentNodeId})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _NodesPageState createState() => _NodesPageState();
}

class _NodesPageState extends State<NodesPage> with SingleTickerProviderStateMixin {


  Repository get _repository => widget._repository;
  NodesBloc _nodesBloc;
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
                                  Icons.collections_bookmark,
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
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.grey,
                          ),
                          onPressed: (){

                          },
                        ),
                        SizedBox(width: 25,),

                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.grey,
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditNodeScreen(repository: _repository)));

                          },
                        ),
                        SizedBox(width: 25,),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_upward,
                            size: 30,
                            color: Colors.grey,
                          ),
                          onPressed: (){

                          },
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
                        if (state.nodes.isEmpty) {
                          return Center(
                            child: Text('No Nodes'),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.nodes.length,
                          itemBuilder: (context, i) => Container(
                            margin: EdgeInsets.only(left: 15, bottom: 15),
                            child: GestureDetector(
                              onTap: (){

                                if(state.nodes[i].isCardNode){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository,parentNodeId: state.nodes[i].sId)));
                                } else {

                                  _nodesBloc = BlocProvider.of<NodesBloc>(context);
                                  _nodesBloc.add(Fetch(parentNodeId: state.nodes[i].sId));
                                  setState(() {

                                  });

                                }

                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: 200,

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
                                  gradient: state.nodes[i].isCardNode
                                      ? new LinearGradient(
                                      colors: [Colors.brown, Colors.brown[200]],
                                      begin: Alignment.topRight,
                                      end: Alignment.topLeft
                                  )
                                      : new LinearGradient(
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
                                    Expanded(
                                      child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Container(
                                              child: Text('${state.nodes[i].title}',
                                                style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                    Center(
                                      child: Icon(
                                        state.nodes[i].isCardNode ? Icons.book : Icons.adjust,
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
                      if(state is Loading){
                        return Center(
                          child: CircularProgressIndicator(),
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
                  child: BlocBuilder<NodesBloc, NodesState>(
                    builder: (context, state) {
                      if (state is Failure) {
                        return Center(
                          child: Text('failed to load'),
                        );
                      }
                      if (state is Loaded) {
                        if (state.nodes.isEmpty) {
                          return Center(
                            child: Text('Not available'),
                          );
                        }
                        return RaisedButton(
                          color: Colors.deepPurple,
                          onPressed: () {

                            _navigateAndAddNode(context, state.nodes[0].parent.sId);

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
                        );
                      }
                      if(state is Loading){
                        return Center(
                          child: CircularProgressIndicator(),
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

  _navigateAndAddNode(BuildContext context, String parentNodeId) async {

   await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddNodeScreen(repository: _repository))).then((value){
      setState(() {
        _nodesBloc = BlocProvider.of<NodesBloc>(context);
        _nodesBloc.add(Fetch(parentNodeId: "5e16f2fb8cc29a2feb748391"));
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

}




