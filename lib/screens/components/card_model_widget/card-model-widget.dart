import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/models/models/card-model.dart';
import 'package:rewizzit/data/services/repository.dart';
import './bloc/bloc.dart';
import 'package:rewizzit/screens/editCard/editCard-screen.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';

class CardModelWidget extends StatefulWidget {
  final CardModel cardModel;


  const CardModelWidget({Key key, @required this.cardModel}) : super(key: key);

  @override
  _CardModelWidgetState createState() => _CardModelWidgetState();
}


class _CardModelWidgetState extends State<CardModelWidget> with SingleTickerProviderStateMixin{

  final Repository _repository = Repository();

  CardModelBloc _cardModelBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return BlocProvider<CardModelBloc>(
      create: (context) => CardModelBloc(repository: _repository),
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
            margin: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.cardModel.title,
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(widget.cardModel.content,
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, parentNodeId: widget.cardModel.parentNode.sId,)));
                      },
                      child: Chip(
                        backgroundColor: Colors.green,
                        label: Text(widget.cardModel.parentNode.title,
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    )
                  ],

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    BlocBuilder<CardModelBloc, CardModelState>(
                      builder: (context, state){
                        if(state is Revised){
                          if(state.revisionResponse == "added"){
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

                          } else {
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
                      },

                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 25,
                        color: Colors.grey,
                      ),
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditCardScreen(repository: _repository)));
                      },
                    ),
                    BlocBuilder<CardModelBloc, CardModelState>(
                      builder: (context, state){
                        if(state is Bookmarked){
                          if(state.bookmarkResponse == "bookmarked"){
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

                          } else {
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
          )
      )
    );
  }

}
