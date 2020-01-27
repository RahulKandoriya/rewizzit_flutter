import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
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
                    Text("Select Node",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 150,
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
                                  Icons.adjust,
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
                  height: 100,
                  width: double.infinity,
                  child: BlocBuilder<SelectNodeBloc, SelectNodeState>(
                    builder: (context, state) {
                      if (state is Failure) {
                        return Center(
                          child: Text('Failed to fetch Data'),
                        );
                      }
                      if (state is Loaded) {
                        if (state.nodes.isEmpty) {
                          return Center(
                            child: Text('No Data'),
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

                                  prefs.setString("parentNodeId", state.nodes[i].sId);
                                  Navigator.pop(context, state.nodes[i].title);

                                } else {

                                  _selectNodeBloc= BlocProvider.of<SelectNodeBloc>(context);
                                  _selectNodeBloc.add(Fetch(parentNodeId: state.nodes[i].sId));
                                  setState(() {

                                  });

                                }
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
                                                width: 80,
                                                child: Text('${state.nodes[i].title}',
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
                                        state.nodes[i].isCardNode ? Icons.book : Icons.adjust,
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
                        if (state.nodes.isEmpty) {
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
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                SizedBox(height: 60,)
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




