import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/revisionCards/bloc/revision-cards-bloc.dart';
import 'package:rewizzit/screens/revisionCards/bloc/revision-cards-state.dart';
import 'package:rewizzit/screens/components/revision_card_model_widget/revision-card-model-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevisionCardsPage extends StatefulWidget {

  final Repository _repository;

  RevisionCardsPage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _RevisionCardsPageState createState() => _RevisionCardsPageState();
}

class _RevisionCardsPageState extends State<RevisionCardsPage> with SingleTickerProviderStateMixin {


  PageController controller = PageController(viewportFraction: .8);
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
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Text("Cards",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Revision Cards",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                    child: BlocBuilder<RevisionCardsBloc, RevisionCardsState>(
                      builder: (context, state) {
                        if (state is Failure) {
                          return Center(
                            child: Text('failed to fetch posts'),
                          );
                        }
                        if (state is Loaded) {
                          if (state.bookmarkCards.isEmpty) {
                            return Center(
                              child: Text('no posts'),
                            );
                          }
                          return PageView.builder(
                            itemCount: 10,
                            itemBuilder: (context, i) => RevisionCardModelWidget(cardModel: state.bookmarkCards[0],),
                            controller: PageController(viewportFraction: .8),
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
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 100, right: 100),
                        child: RaisedButton(
                          color: Colors.deepPurple,
                          onPressed: () {

                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.done_outline,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("Revise",
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




