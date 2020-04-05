import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/bookmark/bookmark.dart';
import 'package:rewizzit/screens/components/card_model_widget/card-model-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkPage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences prefs;
  final int cardPosition;

  BookmarkPage({Key key, @required Repository repository, @required this.prefs, @required this.cardPosition})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> with SingleTickerProviderStateMixin {


  SharedPreferences get prefs => widget.prefs;
  int get cardPosition => widget.cardPosition;

  PageController controller;
  var currentPageValue ;
  double _currentIndex = 0;

  double _lowerValue = 0;

  BookmarkBloc _bookmarkBloc;

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

    _bookmarkBloc = BlocProvider.of<BookmarkBloc>(context);

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
                    Text("Bookmarked",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Cards",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
                Container(
                  height: 450,
                  width: double.infinity,
                  child: BlocBuilder<BookmarkBloc, BookmarkState>(
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
                          itemCount: state.bookmarkCards.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, i) => CardModelWidget(cardModel: state.bookmarkCards[i], prefs: prefs, bookmarkBloc: _bookmarkBloc,),
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
                    SizedBox(height: 50,),
                    Visibility(
                      visible: true,
                      child: BlocBuilder<BookmarkBloc, BookmarkState>(
                        builder: (context, state) {
                          if (state is Failure) {
                            return Center(
                              child: Text('failed to fetch'),
                            );
                          }
                          if (state is Loaded) {
                            if (state.bookmarkCards.isEmpty) {
                              return Center(
                                child: Text('no posts'),
                              );
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Select Card (${(currentPageValue + 1).floor()}/${state.bookmarkCards.length})",
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 40, right: 40,),
                                  child: Slider(
                                    activeColor: Colors.indigoAccent,
                                    min: 0,
                                    max: state.bookmarkCards.length.toDouble() - 1,
                                    onChanged: (currentValue) {
                                      setState(() {

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




