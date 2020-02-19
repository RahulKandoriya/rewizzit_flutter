import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/allRevisionCards/bloc/bloc.dart';
import 'package:rewizzit/screens/allRevisionCards/bloc/all-revision-cards-bloc.dart';
import 'package:rewizzit/screens/allRevisionCards/bloc/all-revision-cards-state.dart';
import 'package:rewizzit/screens/components/all_revision_card_model_widget/all-revision-card-model-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllRevisionCardsPage extends StatefulWidget {

  final Repository repository;
  final int cardPosition;
  final SharedPreferences prefs;

  AllRevisionCardsPage({Key key, @required  this.repository, @required this.cardPosition, @required this.prefs,})
      : super(key: key);


  @override
  _AllRevisionCardsPageState createState() => _AllRevisionCardsPageState();
}

class _AllRevisionCardsPageState extends State<AllRevisionCardsPage> with SingleTickerProviderStateMixin {

  SharedPreferences get prefs => widget.prefs;
  int get cardPosition => widget.cardPosition;

  PageController controller;
  var currentPageValue;
  bool isAppBarUp;

  int revisionLength;
  double _lowerValue = 0;


  AllRevisionCardsBloc _revisionCardsBloc;

  @override
  void initState() {
    super.initState();

    currentPageValue = cardPosition.toDouble();
    controller = PageController( initialPage: cardPosition,keepPage: true, viewportFraction: 0.8);
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    _revisionCardsBloc = BlocProvider.of<AllRevisionCardsBloc>(context);
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
                      SizedBox(height: 20,),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          refresh();
                        },
                        child: Text("Revision",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: 230,
                        child: Text("Cards",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: BlocBuilder<AllRevisionCardsBloc, AllRevisionCardsState>(
                        builder: (context, state) {
                          if (state is Failure) {
                            return Center(
                              child: Text('failed to fetch Data'),
                            );
                          }
                          if (state is Loaded) {
                            if (state.revisionCards.isEmpty) {
                              return Center(
                                child: Text('No Cards'),
                              );
                            }

                            revisionLength = state.revisionCards.length;

                            return PageView.builder(
                              itemCount: state.revisionCards.length,
                              itemBuilder: (context, i) => AllRevisionCardModelWidget(revisionCard: state.revisionCards[i], prefs: prefs, revisionCardsBloc: _revisionCardsBloc, notifyParent: refresh,),
                              controller: controller,
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: BlocBuilder<AllRevisionCardsBloc, AllRevisionCardsState>(
                      builder: (context, state) {
                        if (state is Failure) {
                          return Center(
                            child: Text('failed to fetch'),
                          );
                        }
                        if (state is Loaded) {
                          if (state.revisionCards.isEmpty) {
                            return Center(
                              child: Text('no posts'),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Select Card (${(currentPageValue + 1).floor()}/${state.revisionCards.length})",
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 40, right: 40,),
                                child: Slider(
                                  activeColor: Colors.indigoAccent,
                                  min: 0,
                                  max: state.revisionCards.length.toDouble() - 1,
                                  onChanged: (currentValue) {
                                    setState(() {

                                      print(currentValue);
                                      controller.animateToPage(currentValue.floor(), duration: Duration(milliseconds: 200), curve: Curves.linear);

                                    });
                                  },
                                  value: currentPageValue,
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
                  SizedBox(height: 10,),
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
        ],
      ),
    );
  }

  refresh() {

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}




