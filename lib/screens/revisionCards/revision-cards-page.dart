import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/revisionCards/bloc/bloc.dart';
import 'package:rewizzit/screens/revisionCards/bloc/revision-cards-bloc.dart';
import 'package:rewizzit/screens/revisionCards/bloc/revision-cards-state.dart';
import 'package:rewizzit/screens/components/revision_card_model_widget/revision-card-model-widget.dart';
import 'package:rewizzit/screens/revisoin_complete_screen/revisoin-complete-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevisionCardsPage extends StatefulWidget {

  final Repository repository;
  final int cardPosition;
  final SharedPreferences prefs;

  RevisionCardsPage({Key key, @required  this.repository, @required this.cardPosition, @required this.prefs,})
      : super(key: key);


  @override
  _RevisionCardsPageState createState() => _RevisionCardsPageState();
}

class _RevisionCardsPageState extends State<RevisionCardsPage> with SingleTickerProviderStateMixin {

  SharedPreferences get prefs => widget.prefs;
  int get cardPosition => widget.cardPosition;

  PageController controller;
  var currentPageValue = 0.0;
  bool isAppBarUp;

  int revisionLength;

  RevisionCardsBloc _revisionCardsBloc;

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: cardPosition, keepPage: true);

  }


  @override
  Widget build(BuildContext context) {

    _revisionCardsBloc = BlocProvider.of<RevisionCardsBloc>(context);
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
                        child: Text("Revising same card in less than an hour won't count in progress",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: 320,
                      child: BlocBuilder<RevisionCardsBloc, RevisionCardsState>(
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
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) => RevisionCardModelWidget(revisionCard: state.revisionCards[i], prefs: prefs, revisionCardsBloc: _revisionCardsBloc, notifyParent: refresh,),
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

    if(revisionLength == (controller.page +1).toInt() ){

      WidgetsBinding.instance.addPostFrameCallback((_){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => RevisionCompleteScreen()));
      });
    } else {

      controller.animateToPage((controller.page + 1).toInt(), duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}




