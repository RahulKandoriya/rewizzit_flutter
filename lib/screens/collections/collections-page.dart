import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCollection/addCollection-screen.dart';
import 'package:rewizzit/screens/collections/bloc/bloc.dart';
import 'package:rewizzit/screens/nodesPage/nodes-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionsPage extends StatefulWidget {

  final Repository _repository;

  CollectionsPage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> with SingleTickerProviderStateMixin {

  Repository get _repository => widget._repository;

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
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              title: Text("Collections",
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 100),
              child: BlocBuilder<CollectionsBloc, CollectionsState>(
                builder: (context, state){
                  if (state is Failure) {
                    return Center(
                      child: Text('failed to fetch data'),
                    );
                  }
                  if (state is Loaded) {
                    if (state.topNodes.isEmpty) {
                      return Center(
                        child: Text('no data'),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.topNodes.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository, parentNodeId: state.topNodes[index].sId,)));
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
                                        child: Text('${state.topNodes[index].title}',
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
                                    Icons.collections_bookmark,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 30),
                              ],

                            ),
                          ),
                        );
                      });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },

              )

            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 60, right: 60, bottom: 30),
              child: RaisedButton(
                color: Colors.deepPurple,
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddCollectionScreen(repository: _repository)));

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
                        child: Text("Add Collection",
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




