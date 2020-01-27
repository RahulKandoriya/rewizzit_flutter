import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/revisionCards/revision-cards-screen.dart';
import 'package:rewizzit/screens/tabs/revision/revision.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevisionPage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences preference;

  RevisionPage({Key key, @required Repository repository, @required this.preference})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _RevisionPageState createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> with SingleTickerProviderStateMixin {

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
                    title: Text("Revision",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ],
          ),
        ),
        BlocBuilder<RevisionBloc, RevisionState>(
          builder: (context, state) {
            if (state is Failure) {
              return Center(
                child: Text('Failed to fetch Data'),
              );
            }
            if (state is Loaded) {
              return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      GestureDetector(
                        onTap: (){
                          ///Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RevisionCardsScreen(repository: _repository)));
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                          width: double.infinity,
                          decoration: new BoxDecoration(
                            color: Colors.purple,
                            gradient: new LinearGradient(
                                colors: [Colors.red, Colors.pink],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight
                            ),
                            borderRadius: new BorderRadius.circular(25.0),                        ),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text("How Revision\nWorks",
                                      style: GoogleFonts.josefinSans(
                                        textStyle: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                              ),
                              Spacer(),
                              Center(
                                child: Icon(
                                  Icons.loop,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 30),
                            ],

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
                        width: double.infinity,
                        decoration: new BoxDecoration(
                          color: Colors.purple,
                          gradient: new LinearGradient(
                              colors: [Colors.purple, Colors.lightBlue[200]],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ),
                          borderRadius: new BorderRadius.circular(25.0),                        ),
                        height: 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text("Revision\nOverview",
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                            ),
                            Spacer(),
                            Center(
                              child: Icon(
                                Icons.lightbulb_outline,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 30),
                          ],

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 20),
                                Text("Tailor Your Revision",
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.settings_backup_restore,
                                  size: 30,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 20),

                              ],
                            ),
                            SizedBox(height: 30,),
                            Container(
                              width: double.infinity,
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("10",
                                        style: GoogleFonts.josefinSans(
                                          textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("Cards",
                                        style: GoogleFonts.josefinSans(
                                          textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text("per day to revise",
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40, right: 40,),
                                    child: FlutterSlider(
                                      tooltip: FlutterSliderTooltip(
                                        disabled: true,
                                      ),
                                      values: [0],
                                      max: 30,
                                      min: 0,
                                      onDragging: (handlerIndex, lowerValue, upperValue) {
                                        setState(() {});
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("3",
                                        style: GoogleFonts.josefinSans(
                                          textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("Times",
                                        style: GoogleFonts.josefinSans(
                                          textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text("per card to revise",
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40, right: 40,),
                                    child: FlutterSlider(
                                      tooltip: FlutterSliderTooltip(
                                        disabled: true,
                                      ),
                                      values: [0],
                                      max: 30,
                                      min: 0,
                                      onDragging: (handlerIndex, lowerValue, upperValue) {
                                        setState(() {});
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text("5",
                                        style: GoogleFonts.josefinSans(
                                          textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("Days",
                                        style: GoogleFonts.josefinSans(
                                          textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text("for revision",
                                    style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40, right: 40,),
                                    child: FlutterSlider(
                                      tooltip: FlutterSliderTooltip(
                                        disabled: true,
                                      ),
                                      values: [0],
                                      max: 30,
                                      min: 0,
                                      onDragging: (handlerIndex, lowerValue, upperValue) {
                                        setState(() {});
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 70, right: 70),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          onPressed: (){
                            ///_newTaskModalBottomSheet(context);
                          },
                          color: Colors.blue,
                          child: Center(
                            child: Text("Save the Preference",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                        ),
                      ),
                      SizedBox(height: 150,),

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
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}

void _newTaskModalBottomSheet(context){
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          height: double.infinity,
          color: Colors.grey[200],
          child: new ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 20),
                        Text("Tailor Your Revision",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.settings_backup_restore,
                          size: 30,
                          color: Colors.grey[700],
                        ),
                        SizedBox(width: 20),

                      ],
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: double.infinity,
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("10",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text("Cards",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("per day to revise",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40, right: 40,),
                            child: FlutterSlider(
                              tooltip: FlutterSliderTooltip(
                                disabled: true,
                              ),
                              values: [0],
                              max: 30,
                              min: 0,
                              onDragging: (handlerIndex, lowerValue, upperValue) {
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("3",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text("Times",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("per card to revise",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40, right: 40,),
                            child: FlutterSlider(
                              tooltip: FlutterSliderTooltip(
                                disabled: true,
                              ),
                              values: [0],
                              max: 30,
                              min: 0,
                              onDragging: (handlerIndex, lowerValue, upperValue) {

                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("5",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text("Days",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("for revision",
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40, right: 40,),
                            child: FlutterSlider(
                              tooltip: FlutterSliderTooltip(
                                disabled: true,
                              ),
                              values: [0],
                              max: 30,
                              min: 0,
                              onDragging: (handlerIndex, lowerValue, upperValue) {
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 70, right: 70),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  onPressed: (){
                  },
                  color: Colors.blue,
                  child: Center(
                    child: Text("Save the Preference",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        );
      }
  );
}



