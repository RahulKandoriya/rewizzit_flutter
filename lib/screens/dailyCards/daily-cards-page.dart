import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/components/daily_card_widget/daily-card-model-widget.dart';
import 'package:rewizzit/screens/dailyCards/daily-cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyCardsPage extends StatefulWidget {

  final Repository _repository;

  DailyCardsPage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _DailyCardsPageState createState() => _DailyCardsPageState();
}

class _DailyCardsPageState extends State<DailyCardsPage> with SingleTickerProviderStateMixin {


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
                      Text("Daily Updated",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                    child: BlocBuilder<DailyCardsBloc, DailyCardsState>(
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
                            itemBuilder: (context, i) => DailyCardModelWidget(cardModel: state.bookmarkCards[0],),
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
                      Text("Daily Updated Cards from Us",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 20,),
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




