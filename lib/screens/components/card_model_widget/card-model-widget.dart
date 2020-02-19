import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/models/models/card-model.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/bookmark/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc/bloc.dart';
import 'package:rewizzit/screens/editCard/editCard-screen.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';

class CardModelWidget extends StatefulWidget {
  final CardModel cardModel;
  final SharedPreferences prefs;
  final BookmarkBloc bookmarkBloc;

  const CardModelWidget({Key key, @required this.cardModel, @required this.prefs, @required this.bookmarkBloc}) : super(key: key);

  @override
  _CardModelWidgetState createState() => _CardModelWidgetState();
}


class _CardModelWidgetState extends State<CardModelWidget> with SingleTickerProviderStateMixin{

  final Repository _repository = Repository();
  SharedPreferences get prefs => widget.prefs;
  BookmarkBloc get bookmarkBloc => widget.bookmarkBloc;

  CardModelBloc _cardModelBloc;

  String bookmarkResponse;
  String revisionResponse;

  @override
  void initState() {
    bookmarkResponse = widget.cardModel.isBookmarked ? "bookmarked" : "un-bookmarked";
    revisionResponse = widget.cardModel.revisionRef != null ? "added" : "removed";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider<CardModelBloc>(
      create: (context) => CardModelBloc(repository: _repository, ),
      child: Container(
          margin: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 20),
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[350],
                blurRadius: 2.0, // has the effect of softening the shadow
                spreadRadius: 0.5, // has the effect of extending the shadow
                offset: Offset(
                  5.0, // horizontal, move right 10
                  5.0, // vertical, move down 10
                ),
              )
            ],
            color: Colors.white,
            borderRadius: new BorderRadius.circular(15.0),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.cardModel.title,
                            style: GoogleFonts.amaranth(
                              textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(widget.cardModel.content,
                            style: GoogleFonts.amaranth(
                              textStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _navigateAndEditCard(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                        ],

                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, parentNodeId: widget.cardModel.parentNode.sId, prefs: prefs, isFromNodePage: false,)));
                            },
                            child: Chip(
                              backgroundColor: Colors.green,
                              label: Text(widget.cardModel.parentNode.title,
                                style: TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, parentNodeId: widget.cardModel.parentNode.sId, prefs: prefs, isFromNodePage: false,)));
                            },
                            child: Chip(
                              backgroundColor: Colors.blue,
                              label: Text("Indian History",
                                style: TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        BlocBuilder<CardModelBloc, CardModelState>(

                          builder: (context, state){
                            if(state is Revised){
                              if(state.revisionResponse == "added"){
                                revisionResponse = "added";
                                return IconButton(
                                  icon: Icon(
                                    Icons.loop,
                                    size: 25,
                                    color: Colors.purple,
                                  ),
                                  onPressed: () {
                                    _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                                    _cardModelBloc.add(Revise(cardId: widget.cardModel.sId));
                                  },
                                );

                              } else if(state.revisionResponse == "removed"){
                                revisionResponse = "removed";
                                return IconButton(
                                  icon: Icon(
                                    Icons.loop,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                                    _cardModelBloc.add(Revise(cardId: widget.cardModel.sId));
                                  },
                                );
                              }
                            }
                            if(state is ReviseLoading){
                              return Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if(state is ReviseFailure){

                              return IconButton(
                                icon: Icon(
                                  Icons.loop,
                                  size: 25,
                                  color: revisionResponse == "added" ? Colors.purple : Colors.grey,
                                ),
                                onPressed: () {
                                  _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                                  _cardModelBloc.add(Revise(cardId: widget.cardModel.sId));
                                },
                              );
                            }
                            return IconButton(
                              icon: Icon(
                                Icons.loop,
                                size: 25,
                                color: revisionResponse == "added" ? Colors.purple : Colors.grey,
                              ),
                              onPressed: () {
                                _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                                _cardModelBloc.add(Revise(cardId: widget.cardModel.sId));
                              },
                            );
                          },

                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 25,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _showDialog();

                          },
                        ),
                        BlocBuilder<CardModelBloc, CardModelState>(
                          builder: (context, state){
                            if(state is Bookmarked){
                              if(state.bookmarkResponse == "bookmarked"){
                                bookmarkResponse = "bookmarked";
                                return IconButton(
                                  icon: Icon(
                                    Icons.bookmark,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                                    _cardModelBloc.add(Bookmark(cardId: widget.cardModel.sId));
                                    setState(() {
                                    });
                                  },
                                );

                              } else if(state.bookmarkResponse == "un-bookmarked") {
                                bookmarkResponse = "un-bookmarked";
                                return IconButton(
                                  icon: Icon(
                                    Icons.bookmark_border,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                                    _cardModelBloc.add(Bookmark(cardId: widget.cardModel.sId));
                                    setState(() {
                                    });
                                  },
                                );
                              }
                            }
                            if(state is BookmarkLoading){
                              return Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if(state is BookmarkFailure){

                              return IconButton(
                                icon: Icon(
                                  bookmarkResponse == "bookmarked" ? Icons.bookmark : Icons.bookmark_border,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                                  _cardModelBloc.add(Bookmark(cardId: widget.cardModel.sId));
                                  setState(() {
                                  });
                                },
                              );
                            }
                            return IconButton(
                              icon: Icon(
                                bookmarkResponse == "bookmarked" ? Icons.bookmark : Icons.bookmark_border,
                                size: 25,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                                _cardModelBloc.add(Bookmark(cardId: widget.cardModel.sId));
                                setState(() {
                                });
                              },
                            );
                          },

                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            size: 25,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                            });
                          },
                        ),

                      ],
                    ),
                  ],
                ),


              ],
            ),
          )
      )
    );


  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {

        // return object of type Dialog
        return BlocProvider<CardModelBloc>(
            create: (context) => CardModelBloc(repository: _repository, ),
            child: AlertDialog(
              title: new Text("Delete?"),
              content: Container(
                height: 60,
                child: BlocBuilder<CardModelBloc, CardModelState>(
                  builder: (context, state){
                    if(state is Deleted){
                      if(state.deleteResponse == "card successfully deleted"){
                        bookmarkBloc.add(Fetch());
                        Navigator.of(context).pop();
                      }
                    }
                    if(state is DeleteLoading){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(state is DeleteFailure){

                      return Center(
                        child: Text(
                            "Failure while deleting",
                          style: GoogleFonts.amaranth(
                            textStyle: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Text(
                          "Delete this Card",
                        style: GoogleFonts.amaranth(
                          textStyle: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
                        ),
                      ),
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
                BlocBuilder<CardModelBloc, CardModelState>(
                  builder: (context, state){
                    return new FlatButton(
                      child: new Text("Delete"),
                      onPressed: () {
                        _cardModelBloc = BlocProvider.of<CardModelBloc>(context);
                        _cardModelBloc.add(Delete(cardId: widget.cardModel.sId));
                      },
                    );
                }),

              ],
            ),
        );
      },
    );
  }

  _navigateAndEditCard(BuildContext context) async {

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditCardScreen(repository: _repository, prefs: prefs, cardId: widget.cardModel.sId, cardTitle: widget.cardModel.title, cardContent: widget.cardModel.content, cardParentNodeId: widget.cardModel.parentNode.sId, cardParentNodeTitle: widget.cardModel.parentNode.title,))).then((value){
      bookmarkBloc.add(Fetch());
    });

  }


}
