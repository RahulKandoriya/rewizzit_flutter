import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/tabs/revision/revision.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flare_flutter/flare_actor.dart';

class RevisionPage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences preference;

  RevisionPage({Key key, @required Repository repository, @required this.preference,})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _RevisionPageState createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> with SingleTickerProviderStateMixin {

  Repository get _repository => widget._repository;

  SharedPreferences get preference => widget.preference;

  TabController controller;

  int cardsPerDay = 0;
  int timesPerDay = 0;
  int days = 0;

  int iniCardsPerDay = 0;
  int iniTimesPerDay = 0;
  int iniDays = 0;

  bool isCardsPerDayChanged = false;
  bool isTimesPerCardChanged = false;
  bool isDaysChanged = false;

  bool isChanged = false;

  bool isPressed = false;


  RevisionBloc _revisionBloc;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {


    _revisionBloc = BlocProvider.of<RevisionBloc>(context);

    isChanged = isCardsPerDayChanged || isTimesPerCardChanged || isDaysChanged;

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
              Spacer(),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {

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
                    _showDialog();
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.circular(25.0),                        ),
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text("Revision\nProgress",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                        ),
                        Spacer(),
                        Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: FlareActor("assets/images/books.flr", alignment:Alignment.center, fit:BoxFit.fitHeight, animation:"books_in"),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],

                    ),
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
                          IconButton(
                            onPressed: (){
                              setState(() {
                                isCardsPerDayChanged  = false;
                                isTimesPerCardChanged = false;
                                isDaysChanged = false;
                                _revisionBloc.add(FetchRevisionControls());

                              });
                            },
                            icon: Icon(
                              Icons.settings_backup_restore,
                              size: 30,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(width: 20),

                        ],
                      ),
                      SizedBox(height: 30,),
                      BlocBuilder<RevisionBloc, RevisionState>(
                        builder: (context, state) {
                          if (state is Failure) {
                            return Container(
                              height: 300,
                              child: Center(
                                child: Text('Failed to fetch Data'),
                              ),
                            );
                          }
                          if (state is RevisionControlsLoaded) {

                            iniCardsPerDay = state.revisionControlsGetResponse.data.reviControls.cardsPerDay;
                            iniTimesPerDay = state.revisionControlsGetResponse.data.reviControls.timesPerDay;
                            iniDays = state.revisionControlsGetResponse.data.reviControls.days;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
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
                                          new Text( isCardsPerDayChanged ? '$cardsPerDay' : '$iniCardsPerDay',
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
                                        child: Slider(
                                          max: 20,
                                          min: 0,
                                          onChanged: ( lowerValue) {
                                            setState(() {
                                              isCardsPerDayChanged = true;
                                              cardsPerDay = lowerValue.toInt();
                                            });
                                          },
                                          value: isCardsPerDayChanged ? cardsPerDay.toDouble() : iniCardsPerDay.toDouble(),
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
                                          Text( isTimesPerCardChanged ? '$timesPerDay' : '$iniTimesPerDay',
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
                                        child: Slider(
                                          value: isTimesPerCardChanged ? timesPerDay.toDouble() : iniTimesPerDay.toDouble(),
                                          max: 10,
                                          min: 0,
                                          onChanged: (lowerValue) {
                                            setState(() {
                                              isTimesPerCardChanged = true;
                                              timesPerDay = lowerValue.toInt();
                                            });
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
                                          Text(isDaysChanged ? '$days' : '$iniDays',
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
                                        child: Slider(
                                          value: isDaysChanged ? days.toDouble() : iniDays.toDouble(),
                                          max: 10,
                                          min: 0,
                                          onChanged: ( lowerValue) {
                                            setState(() {

                                              isDaysChanged = true;
                                              days = lowerValue.toInt();

                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          if (state is PostRevisionControlsLoaded) {

                            if(isPressed){
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_){
                                setState(() {
                                  isCardsPerDayChanged = false;
                                  isTimesPerCardChanged = false;
                                  isDaysChanged = false;
                                  isPressed = false;
                                });

                              });

                            }

                            iniCardsPerDay = state.revisionControlsPostResponse.data.cardsPerDay;
                            iniTimesPerDay = state.revisionControlsPostResponse.data.timesPerDay;
                            iniDays = state.revisionControlsPostResponse.data.days;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
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
                                          new Text( isCardsPerDayChanged ? '$cardsPerDay' : '$iniCardsPerDay',
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
                                        child: Slider(
                                          value: cardsPerDay.toDouble(),
                                          max: 20,
                                          min: 0,
                                          onChanged: (lowerValue) {
                                            setState(() {
                                              isCardsPerDayChanged = true;
                                              cardsPerDay = lowerValue.toInt();
                                            });
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
                                          Text( isTimesPerCardChanged ? '$timesPerDay' : '$iniTimesPerDay',
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
                                        child: Slider(
                                          value: timesPerDay.toDouble(),
                                          max: 10,
                                          min: 0,
                                          onChanged: (lowerValue) {
                                            setState(() {

                                              setState(() {
                                                isTimesPerCardChanged = true;
                                                timesPerDay = lowerValue.toInt();
                                              });

                                            });
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
                                          Text(isDaysChanged ? '$days' : '$iniDays',
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
                                        child: Slider(
                                          value: days.toDouble(),
                                          max: 10,
                                          min: 0,
                                          onChanged: ( lowerValue) {
                                            setState(() {

                                              isDaysChanged = true;
                                              days = lowerValue.toInt();

                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return new Container(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 70, right: 70),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    onPressed: isChanged
                    ? (){

                      _revisionBloc.add(PostRevisionControls(cardsPerDay: cardsPerDay.toInt(), timesPerCard: timesPerDay.toInt(), days: days.toInt()));
                      isPressed = true;

                    }
                    : null,
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
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<RevisionBloc>(
            create: (context) => RevisionBloc(repository: _repository, ),
            child: AlertDialog(
              title: new Text("Revision Progress"),
              content: Container(
                height: 100,
                child: BlocBuilder<RevisionBloc, RevisionState>(
                  builder: (context, state){
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Progression of\nRevision till now",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.amaranth(
                                textStyle: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: new LinearPercentIndicator(
                                width: 200,
                                animation: true,
                                lineHeight: 20.0,
                                animationDuration: 2500,
                                percent: 0.8,
                                center: Text("80.0%"),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.green,
                              ),
                            ),
                          ],
                        )
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

              ],
             ),
        );
      },
    );
  }


}



