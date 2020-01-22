import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/recentCards/bloc/bloc.dart';
import 'package:rewizzit/screens/recentCards/recent-cards.dart';
import 'package:rewizzit/screens/components/card_model_widget/card-model-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentCardsPage extends StatefulWidget {

  final Repository _repository;

  RecentCardsPage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _RecentCardsPageState createState() => _RecentCardsPageState();
}

class _RecentCardsPageState extends State<RecentCardsPage> with SingleTickerProviderStateMixin {


  PageController controller = PageController(keepPage: true, viewportFraction: 0.8);
  var currentPageValue = 0.0;
  bool isAppBarUp;
  double _lowerValue = 0;
  double _upperValue = 0;


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
                        if (state.bookmarkCards.isEmpty) {
                          return Center(
                            child: Text('no posts'),
                          );
                        }
                        return PageView.builder(
                          itemCount: 10,
                          itemBuilder: (context, i) => CardModelWidget(cardModel: state.bookmarkCards[0],),
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




