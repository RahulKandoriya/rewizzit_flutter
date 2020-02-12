import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCardFromNode/addCard-screen.dart';
import 'package:rewizzit/screens/components/node-card-widget/node-card-model-widget.dart';
import 'package:rewizzit/screens/editNode/editNode-screen.dart';
import 'package:rewizzit/screens/nodeCards/node-cards.dart';
import 'package:rewizzit/screens/nodesPage/nodes-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NodeCardsPage extends StatefulWidget {

  final Repository _repository;
  final String parentNodeId;
  final SharedPreferences prefs;

  NodeCardsPage({Key key, @required Repository repository, @required this.parentNodeId, @required this.prefs})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _NodeCardsPageState createState() => _NodeCardsPageState();
}

class _NodeCardsPageState extends State<NodeCardsPage> with SingleTickerProviderStateMixin {


  Repository get _repository => widget._repository;
  SharedPreferences get prefs => widget.prefs;
  String navigateUpNodeId;

  PageController controller = PageController(keepPage: true, viewportFraction: 0.8);
  var currentPageValue = 0.0;
  bool isAppBarUp;
  double _lowerValue = 0;
  String currentNodeTitle;
  String currentNodeId;

  NodeCardsBloc _nodeCardsBloc;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });

  }


  @override
  Widget build(BuildContext context) {

    _nodeCardsBloc = BlocProvider.of<NodeCardsBloc>(context);

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40,),
                      BlocBuilder<NodeCardsBloc, NodeCardsState>(
                          builder: (context, state){
                            if (state is Failure) {
                              return Center(
                                child: Text('failed to fetch node'),
                              );
                            }
                            if (state is Loaded) {
                              if( state.nodeCardsResponse.curNode.parent != null){
                                navigateUpNodeId = state.nodeCardsResponse.curNode.parent.sId;
                              } else {
                                navigateUpNodeId = null;
                              }
                              currentNodeTitle = state.nodeCardsResponse.curNode.title;
                              currentNodeId  = state.nodeCardsResponse.curNode.sId;
                              if (state.nodeCardsResponse ==  null) {
                                return Center(
                                  child: Text('no data'),
                                );
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 230,
                                    child: ListView(
                                      children: <Widget>[
                                        Center(
                                          child: Text('${state.nodeCardsResponse.curNode.title}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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

                                          _nodeCardsBloc = BlocProvider.of<NodeCardsBloc>(context);

                                          _showDialog(state, _nodeCardsBloc);

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

                                          _navigateAndEditNode(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );

                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },

                      )
                    ],
                  ),
                  Container(
                    height: 450,
                    width: double.infinity,
                    child: BlocBuilder<NodeCardsBloc, NodeCardsState>(
                      builder: (context, state) {
                        if (state is Failure) {
                          return Center(
                            child: Text('Failed to fetch Cards'),
                          );
                        }
                        if (state is Loaded) {
                          if (state.nodeCardsResponse.data.cards.isEmpty) {
                            return Center(
                              child: Text('No Cards'),
                            );
                          }
                          return PageView.builder(
                            itemCount: state.nodeCardsResponse.data.cards.length,
                            itemBuilder: (context, i) => NodeCardModelWidget(cardModel: state.nodeCardsResponse.data.cards[i], prefs: prefs, nodeCardsBloc: _nodeCardsBloc,),
                            controller: controller,
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: false,
                        child: BlocBuilder<NodeCardsBloc, NodeCardsState>(
                          builder: (context, state) {
                            if (state is Failure) {
                              return Center(
                                child: Text('failed to fetch posts'),
                              );
                            }
                            if (state is Loaded) {
                              if (state.nodeCardsResponse.data.cards.isEmpty) {
                                return Center(
                                  child: Text('no posts'),
                                );
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Select Card (${_lowerValue.floor()}/${state.nodeCardsResponse.data.cards.length})",
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40, right: 40,),
                                    child: Slider(
                                      activeColor: Colors.indigoAccent,
                                      min: 1.0,
                                      max: state.nodeCardsResponse.data.cards.length.toDouble(),
                                      onChanged: (currentValue) {
                                        setState(() {

                                          print(currentValue);
                                          currentPageValue = currentValue;
                                          controller.animateToPage(currentValue.floor(), duration: Duration(milliseconds: 300), curve: Curves.linear);

                                        });
                                      },
                                      value: 1.0,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        margin: EdgeInsets.only(left: 100, right: 100),
                        child: RaisedButton(
                          color: Colors.deepPurple,
                          onPressed: () {
                            _navigateAndAddCard(context);
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
                                  child: Text("Add Card",
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
                      SizedBox(height: 30,),
                    ],
                  ),
                ],
              ),
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
          Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: EdgeInsets.only(right: 20, top: 30),
                child: IconButton(
                  onPressed: (){
                    if(navigateUpNodeId != null){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository, parentNodeId: "?id=" + navigateUpNodeId, prefs: prefs,)));
                    }
                  },
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Colors.black,
                  ),
                )
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(Loaded loadedState, NodeCardsBloc nodesBloc) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {

        // return object of type Dialog
        return BlocProvider<NodeCardsBloc>(
          create: (context) => NodeCardsBloc(repository: _repository, ),
          child: AlertDialog(
            title: new Text("Delete?"),
            content: Container(
              height: 60,
              child: BlocBuilder<NodeCardsBloc, NodeCardsState>(
                builder: (context, state){
                  if(state is NodeDeleted){
                    if(state.deleteResponse == "Node deleted"){
                      WidgetsBinding.instance.addPostFrameCallback((_){

                        if(loadedState.nodeCardsResponse.curNode.parent.title ==  null){
                          nodesBloc.add(Fetch(parentNodeId: ""));
                        } else {
                          nodesBloc.add(Fetch(parentNodeId: "?id=" + loadedState.nodeCardsResponse.curNode.parent.sId));
                        }
                        Navigator.of(context).pop();
                      });

                    }
                  }
                  if(state is NodeDeleteLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(state is NodeDeleteFailure){

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
              BlocBuilder<NodeCardsBloc, NodeCardsState>(
                  builder: (context, state){
                    return new FlatButton(
                      child: new Text("Delete"),
                      onPressed: () {
                        _nodeCardsBloc = BlocProvider.of<NodeCardsBloc>(context);
                        _nodeCardsBloc.add(NodeDelete(nodeId: currentNodeId));
                      },
                    );
                  }),

            ],
          ),
        );
      },
    );
  }


  _navigateAndAddCard(BuildContext context) async {

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddCardFromNodeScreen(repository: _repository, prefs: prefs, parentNodeId: currentNodeId,parentNodeTitle: currentNodeTitle,))).then((value){
      setState(() {
        _nodeCardsBloc = BlocProvider.of<NodeCardsBloc>(context);
        _nodeCardsBloc.add(FetchAfterAddingCard(parentNodeId: currentNodeId));
      });
    });

  }

  _navigateAndEditNode(BuildContext context) async {

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditNodeScreen(repository: _repository, prefs: prefs, parentNodeTitle: currentNodeTitle, parentNodeId: currentNodeId,))).then((value){
      setState(() {
        _nodeCardsBloc.add(FetchAfterAddingCard(parentNodeId: currentNodeId));
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

}




