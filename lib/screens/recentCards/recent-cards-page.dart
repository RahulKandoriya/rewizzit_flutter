import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/components/recent_card_model_widget/recent-card-model-widget.dart';
import 'package:rewizzit/screens/recentCards/bloc/bloc.dart';
import 'package:rewizzit/screens/recentCards/recent-cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentCardsPage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences prefs;
  final int cardPosition;

  RecentCardsPage({Key key, @required Repository repository, @required this.prefs, @required this.cardPosition})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _RecentCardsPageState createState() => _RecentCardsPageState();
}

class _RecentCardsPageState extends State<RecentCardsPage> with SingleTickerProviderStateMixin {

  SharedPreferences get prefs => widget.prefs;
  int get cardPosition => widget.cardPosition;
  PageController controller;
  var currentPageValue = 0.0;

  RecentCardsBloc _recentCardsBloc;


  @override
  void initState() {
    controller = PageController(initialPage: cardPosition, viewportFraction: .8, keepPage: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    _recentCardsBloc = BlocProvider.of<RecentCardsBloc>(context);

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
                    Text("Cards",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Recently Added",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  child: BlocBuilder<RecentCardsBloc, RecentCardsState>(
                    builder: (context, state) {
                      if (state is Failure) {
                        return Center(
                          child: Text('failed to fetch posts'),
                        );
                      }
                      if (state is Loaded) {
                        if (state.recentCards.isEmpty) {
                          return Center(
                            child: Text('no posts'),
                          );
                        }
                        return PageView.builder(
                          itemCount: state.recentCards.length,
                          itemBuilder: (context, i) => RecentCardModelWidget(cardModel: state.recentCards[i], prefs: prefs, recentCardsBloc: _recentCardsBloc,),
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
                    SizedBox(height: 10,),
                    Text("Recent Cards you have Added",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
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

}




