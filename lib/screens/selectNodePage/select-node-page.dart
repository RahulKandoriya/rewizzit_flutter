import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addNode/addNode-screen.dart';
import 'package:rewizzit/screens/editNode/editNode-screen.dart';
import './select-node.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectNodePage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences prefs;

  SelectNodePage({Key key, @required Repository repository, @required this.prefs})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _SelectNodePageState createState() => _SelectNodePageState();
}

class _SelectNodePageState extends State<SelectNodePage> with SingleTickerProviderStateMixin {


  Repository get _repository => widget._repository;
  SharedPreferences get prefs => widget.prefs;
  SelectNodeBloc _selectNodeBloc;
  String parentNodeId;
  PageController controller = PageController(keepPage: true, viewportFraction: 0.8);


  List<CardsNodesData> cardNodes = [new CardsNodesData(isCardNode: true, isInRevision: false, title: "Fetching", sId: "id", userRef: "userRef", createdAt: "createdAt", updatedAt: "updatedAt", iV: 1)];

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
                    SizedBox(height: 20,),
                    BlocBuilder<SelectNodeBloc, SelectNodeState>(
                      builder: (context, state) {
                        if (state is Failure) {
                          return Container(
                            height: 200,
                            margin: EdgeInsets.only(bottom: 15),
                            child: Center(
                              child: Text('failed to fetch data'),
                            ),
                          );
                        }
                        if (state is Loaded) {

                          if (state.subNodesResponse.curNode == null) {
                            return Container(
                              height: 200,
                              margin: EdgeInsets.only(bottom: 15),
                              child: Center(
                                child: Text('No Node'),
                              ),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 150,
                                margin: EdgeInsets.only(bottom: 15),
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

                                      _navigateAndEditNode(context, parentNodeId, state.subNodesResponse.curNode.title);
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

                                      _selectNodeBloc = BlocProvider.of<SelectNodeBloc>(context);

                                      if(state.subNodesResponse.curNode.parent.title ==  null){
                                        _selectNodeBloc.add(FetchSubNodes(parentNodeId: ""));
                                        setState(() {});
                                      } else {
                                        _selectNodeBloc.add(FetchSubNodes(parentNodeId: "?id=" + state.subNodesResponse.curNode.parent.sId));
                                        setState(() {});
                                      }
                                    },
                                  ),


                                ],
                              ),
                            ],
                          );
                        }
                        if(state is NodesLoading){
                          return Container(
                            height: 200,
                            margin: EdgeInsets.only(bottom: 15),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return Container(
                          height: 200,
                          margin: EdgeInsets.only(bottom: 15),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),



                  ],
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: BlocBuilder<SelectNodeBloc, SelectNodeState>(
                    builder: (context, state) {
                      if (state is Failure) {
                        return Center(
                          child: Text('failed to fetch posts'),
                        );
                      }
                      if (state is Loaded) {

                        parentNodeId = state.subNodesResponse.curNode.sId;

                        cardNodes = state.cardNodes;

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

                                  prefs.setString("parentNodeId", state.subNodesResponse.data.nodes[i].sId);
                                  Navigator.pop(context, state.subNodesResponse.data.nodes[i].title);

                                } else {

                                  _selectNodeBloc = BlocProvider.of<SelectNodeBloc>(context);
                                  _selectNodeBloc.add(FetchSubNodes(parentNodeId: "?id=" + state.subNodesResponse.data.nodes[i].sId));
                                  setState(() {

                                  });

                                }

                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                padding: EdgeInsets.all(10),
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
                                        size: 30,
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
                      if(state is NodesLoading || state is Loading){
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
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20,),
                    Text("Card Nodes",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: BlocBuilder<SelectNodeBloc, SelectNodeState>(
                    builder: (context, state) {
                      if (state is Failure) {
                        return Center(
                          child: Text('failed to fetch Card Nodes'),
                        );
                      }
                      if (state is Loaded) {
                        if (state.cardNodes.isEmpty) {
                          return Center(
                            child: Text('No Card Nodes'),
                          );
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.cardNodes.length,
                          itemBuilder: (context, i) => Container(
                            margin: EdgeInsets.only(left: 15, bottom: 15),
                            child: GestureDetector(
                              onTap: (){

                                prefs.setString("parentNodeId", state.cardNodes[i].sId);
                                Navigator.pop(context, state.cardNodes[i].title);

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
                                  gradient:new LinearGradient(
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
                                              child: Container(
                                                child: Text('${state.cardNodes[i].title}',
                                                  style: GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                              )
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                    Center(
                                      child: Icon(
                                        Icons.book,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                  ],

                                ),
                              ),
                            ),
                          ),

                        );
                      }

                      if (state is Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardNodes.length,
                        itemBuilder: (context, i) => Container(
                          margin: EdgeInsets.only(left: 15, bottom: 15),
                          child: GestureDetector(
                            onTap: (){

                              prefs.setString("parentNodeId", cardNodes[i].sId);
                              Navigator.pop(context, cardNodes[i].title);

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
                                gradient:new LinearGradient(
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
                                            child: Container(
                                              child: Text('${cardNodes[i].title}',
                                                style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                                ),
                                              ),
                                            )
                                        )
                                    ),
                                  ),
                                  SizedBox(width: 15,),
                                  Center(
                                    child: Icon(
                                      Icons.book,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                ],

                              ),
                            ),
                          ),
                        ),

                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: 100, right: 100, bottom: 50),
                  child: RaisedButton(
                    color: Colors.deepPurple,
                    onPressed: () {

                      _navigateAndAddNode(context, parentNodeId);

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

  @override
  void dispose() {
    super.dispose();
  }

  _navigateAndAddNode(BuildContext context, String parentNodeId) async {

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddNodeScreen(repository: _repository, prefs: prefs, parentNodeId: parentNodeId,))).then((value){
      setState(() {
        _selectNodeBloc = BlocProvider.of<SelectNodeBloc>(context);
        if(parentNodeId == null){
          _selectNodeBloc.add(FetchSubNodes(parentNodeId: ""));
        } else {
          _selectNodeBloc.add(FetchSubNodes(parentNodeId: "?id=" + parentNodeId));
        }
      });
    });

  }

  _navigateAndEditNode(BuildContext context, String parentNodeId, String parentNodeTitle) async {

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditNodeScreen(repository: _repository, prefs: prefs, parentNodeTitle: parentNodeTitle, parentNodeId: parentNodeId))).then((value){
      setState(() {
        _selectNodeBloc = BlocProvider.of<SelectNodeBloc>(context);
        _selectNodeBloc.add(FetchSubNodes(parentNodeId: "?id=" + parentNodeId));
      });
    });

  }


}




