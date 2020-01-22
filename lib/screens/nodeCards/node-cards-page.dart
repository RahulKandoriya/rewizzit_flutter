import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCard/addCard-screen.dart';
import 'package:rewizzit/screens/components/node-card-widget/node-card-model-widget.dart';
import 'package:rewizzit/screens/nodeCards/node-cards.dart';
import 'package:rewizzit/screens/nodesPage/nodes-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NodeCardsPage extends StatefulWidget {

  final Repository _repository;

  NodeCardsPage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _NodeCardsPageState createState() => _NodeCardsPageState();
}

class _NodeCardsPageState extends State<NodeCardsPage> with SingleTickerProviderStateMixin {


  Repository get _repository => widget._repository;
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
                      Text("Node Title",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 450,
                    width: double.infinity,
                    child: BlocBuilder<NodeCardsBloc, NodeCardsState>(
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
                            itemBuilder: (context, i) => NodeCardModelWidget(cardModel: state.bookmarkCards[0],),
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
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40,),
                        child: FlutterSlider(
                          values: [0],
                          max: 10,
                          min: 0,
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            _lowerValue = lowerValue;
                            _upperValue = upperValue;
                            setState(() {
                              print(handlerIndex);
                              print(lowerValue);
                              controller.animateToPage(_lowerValue.floor(), duration: Duration(milliseconds: 300), curve: Curves.linear);

                            });
                          },
                        ),
                      ),
                      Text("Select Card (${_lowerValue.floor()}/10)",
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        margin: EdgeInsets.only(left: 100, right: 100),
                        child: RaisedButton(
                          color: Colors.deepPurple,
                          onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddCardScreen(repository: _repository)));
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
                                  child: Text("Add Card",
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
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.only(right: 20, top: 30),
                child: Icon(
                    Icons.arrow_upward
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




