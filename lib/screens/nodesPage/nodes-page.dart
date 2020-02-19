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
  final SharedPreferences prefs;

  NodesPage({Key key, @required Repository repository, @required this.parentNodeId, @required this.prefs})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _NodesPageState createState() => _NodesPageState();
}

class _NodesPageState extends State<NodesPage> with SingleTickerProviderStateMixin {


  Repository get _repository => widget._repository;
  SharedPreferences get prefs => widget.prefs;

  NodesBloc _nodesBloc;
  PageController controller = PageController(keepPage: true, viewportFraction: 0.8);
  var currentPageValue = 0.0;

  String currentNodeId;

  Loaded loadedState;

  @override
  void initState() {
    super.initState();
  }


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
                    BlocBuilder<NodesBloc, NodesState>(
                      builder: (context, state) {
                        if (state is Failure) {
                          return Center(
                            child: Text('failed to fetch data'),
                          );
                        }
                        if (state is Loaded) {

                          if (state.subNodesResponse.curNode == null) {
                            return Center(
                              child: Text('No Node'),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 200,
                                margin: EdgeInsets.only(bottom: 15),
                                child: GestureDetector(
                                  onTap: (){

                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    width: 250,

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
                                                child: Text('${state.subNodesResponse.curNode.title}',
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
                                            Icons.album,
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
                                        color: state.subNodesResponse.curNode.title == "All Nodes"
                                            ? Colors.grey[200]
                                            : Colors.grey
                                    ),
                                    onPressed: state.subNodesResponse.curNode.title == "All Nodes"
                                        ? null
                                        : (){

                                      loadedState = state;
                                      _nodesBloc = BlocProvider.of<NodesBloc>(context);
                                      _showDialog(loadedState, _nodesBloc);
                                    },
                                  ),
                                  SizedBox(width: 25,),

                                  IconButton(
                                    icon: Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: state.subNodesResponse.curNode.title == "All Nodes"
                                            ? Colors.grey[200]
                                            : Colors.grey
                                    ),
                                    onPressed: state.subNodesResponse.curNode.title == "All Nodes"
                                        ? null
                                        : (){

                                      _navigateAndEditNode(context, currentNodeId, state.subNodesResponse.curNode.title);
                                    },
                                  ),
                                  SizedBox(width: 25,),
                                  IconButton(
                                    icon: Icon(
                                        Icons.arrow_upward,
                                        size: 30,
                                        color: state.subNodesResponse.curNode.title == "All Nodes"
                                            ? Colors.grey[200]
                                            : Colors.grey
                                    ),
                                    onPressed: state.subNodesResponse.curNode.title == "All Nodes"
                                        ? null
                                        : (){

                                      _nodesBloc = BlocProvider.of<NodesBloc>(context);

                                      if(state.subNodesResponse.curNode.parent.title ==  null){
                                        _nodesBloc.add(Fetch(parentNodeId: ""));
                                        setState(() {});
                                      } else {
                                        _nodesBloc.add(Fetch(parentNodeId: "?id=" + state.subNodesResponse.curNode.parent.sId));
                                        setState(() {});
                                      }
                                    },
                                  ),


                                ],
                              ),
                            ],
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

                        currentNodeId = state.subNodesResponse.curNode.sId;

                        if (state.subNodesResponse.data.nodes.isEmpty) {
                          return Center(
                            child: Text('No Nodes'),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.subNodesResponse.data.nodes.length,
                          itemBuilder: (context, i) => Container(
                            margin: EdgeInsets.only(left: 15, bottom: 15),
                            child: GestureDetector(
                              onTap: (){

                                if(state.subNodesResponse.data.nodes[i].isCardNode){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, prefs: prefs,parentNodeId: state.subNodesResponse.data.nodes[i].sId, isFromNodePage: true,)));
                                } else {

                                  _nodesBloc = BlocProvider.of<NodesBloc>(context);
                                  _nodesBloc.add(Fetch(parentNodeId: "?id=" + state.subNodesResponse.data.nodes[i].sId));
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
                                  gradient: state.subNodesResponse.data.nodes[i].isCardNode
                                      ? new LinearGradient(
                                      colors: [Colors.lightBlue, Colors.lightBlue[200]],
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
                                              child: Text('${state.subNodesResponse.data.nodes[i].title}',
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
                                        state.subNodesResponse.data.nodes[i].isCardNode ? Icons.book : Icons.adjust,
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
                  child: RaisedButton(
                    color: Colors.deepPurple,
                    onPressed: () {

                      _navigateAndAddNode(context, currentNodeId);

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
          Padding(
              padding: EdgeInsets.only(left: 20, top: 30),
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                    Icons.close
                ),
              )
          ),
        ],
      ),
    );
  }

  void _showDialog(Loaded loadedState, NodesBloc nodesBloc) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {

        // return object of type Dialog
        return BlocProvider<NodesBloc>(
          create: (context) => NodesBloc(repository: _repository, ),
          child: AlertDialog(
            title: new Text("Delete?"),
            content: Container(
              height: 60,
              child: BlocBuilder<NodesBloc, NodesState>(
                builder: (context, state){
                  if(state is Deleted){
                    if(state.deleteResponse == "Node deleted"){
                      WidgetsBinding.instance.addPostFrameCallback((_){

                        if(loadedState.subNodesResponse.curNode.parent.title ==  null){
                          nodesBloc.add(Fetch(parentNodeId: ""));
                        } else {
                          nodesBloc.add(Fetch(parentNodeId: "?id=" + loadedState.subNodesResponse.curNode.parent.sId));
                        }
                        Navigator.of(context).pop();
                      });

                    }
                  }
                  if(state is DeleteLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(state is DeleteFailure){

                    return Center(
                      child: Text(
                        "Failure while deleting",
                        style: GoogleFonts.amaranth(
                          textStyle: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "Delete this Node",
                      style: GoogleFonts.amaranth(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
                      ),
                    ),
                  );
                },

              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              BlocBuilder<NodesBloc, NodesState>(
                  builder: (context, state){
                    return new FlatButton(
                      child: new Text("Delete"),
                      onPressed: () {
                        _nodesBloc = BlocProvider.of<NodesBloc>(context);
                        _nodesBloc.add(Delete(nodeId: currentNodeId));
                      },
                    );
                  }),

            ],
          ),
        );
      },
    );
  }

  _navigateAndAddNode(BuildContext context, String parentNodeId) async {

   await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddNodeScreen(repository: _repository, prefs: prefs, parentNodeId: parentNodeId,))).then((value){
      setState(() {
        _nodesBloc = BlocProvider.of<NodesBloc>(context);
        if(parentNodeId == null){
          _nodesBloc.add(Fetch(parentNodeId: ""));
        } else {
          _nodesBloc.add(Fetch(parentNodeId: "?id=" + parentNodeId));
        }
      });
    });

  }

  _navigateAndEditNode(BuildContext context, String parentNodeId, String parentNodeTitle) async {

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditNodeScreen(repository: _repository, prefs: prefs, parentNodeTitle: parentNodeTitle, parentNodeId: parentNodeId))).then((value){
      setState(() {
        _nodesBloc = BlocProvider.of<NodesBloc>(context);
        _nodesBloc.add(Fetch(parentNodeId: "?id=" + parentNodeId));
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

}




