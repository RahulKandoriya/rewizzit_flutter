import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/models/api_response/api-response.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/components/all_revision_card_model_widget/bloc/bloc.dart';
import 'package:rewizzit/screens/editCard/editCard-screen.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rewizzit/screens/allRevisionCards/bloc/bloc.dart';

class AllRevisionCardModelWidget extends StatefulWidget {
  final Revisions revisionCard;
  final SharedPreferences prefs;
  final AllRevisionCardsBloc revisionCardsBloc;
  final Function() notifyParent;


  const AllRevisionCardModelWidget({Key key, @required this.revisionCard, @required this.prefs, @required this.revisionCardsBloc, @required this.notifyParent}) : super(key: key);

  @override
  _AllRevisionCardModelWidgetState createState() => _AllRevisionCardModelWidgetState();
}


class _AllRevisionCardModelWidgetState extends State<AllRevisionCardModelWidget> with SingleTickerProviderStateMixin{

  final Repository _repository = Repository();
  SharedPreferences get prefs => widget.prefs;

  Function() get notifyparent => widget.notifyParent;

  AllRevisionCardModelBloc _revisionCardModelBloc;
  String bookmarkResponse;
  String revisionResponse;
  AllRevisionCardsBloc get revisionCardsBloc => widget.revisionCardsBloc;


  @override
  void initState() {
    bookmarkResponse = widget.revisionCard.card.isBookmarked ? "bookmarked" : "un-bookmarked";
    revisionResponse = widget.revisionCard.card.revisionRef != null ? "added" : "removed";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider<AllRevisionCardModelBloc>(
      create: (context) => AllRevisionCardModelBloc(repository: _repository,),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          Container(
              height: 450,
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
                margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 15),
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
                              Text(widget.revisionCard.card.title,
                                style: GoogleFonts.amaranth(
                                  textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(widget.revisionCard.card.content,
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

                          )
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
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, parentNodeId: widget.revisionCard.card.parentNode.sId, prefs: prefs, isFromNodePage: false,)));
                                },
                                child: Chip(
                                  backgroundColor: Colors.green,
                                  label: Text(widget.revisionCard.card.parentNode.title,
                                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8,),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodeCardsScreen(repository: _repository, parentNodeId: widget.revisionCard.card.parentNode.sId, prefs: prefs, isFromNodePage: false,)));
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

                            BlocBuilder<AllRevisionCardModelBloc, AllRevisionCardModelState>(
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
                                        _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                                        _revisionCardModelBloc.add(Revise(cardId: widget.revisionCard.card.sId));
                                      },
                                    );

                                  } else if(state.revisionResponse == "removed") {
                                    revisionResponse = "removed";
                                    return IconButton(
                                      icon: Icon(
                                        Icons.loop,
                                        size: 25,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                                        _revisionCardModelBloc.add(Revise(cardId: widget.revisionCard.card.sId));
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
                                      _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                                      _revisionCardModelBloc.add(Revise(cardId: widget.revisionCard.card.sId));
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
                                    _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                                    _revisionCardModelBloc.add(Revise(cardId: widget.revisionCard.card.sId));
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
                            BlocBuilder<AllRevisionCardModelBloc, AllRevisionCardModelState>(
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
                                        _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                                        _revisionCardModelBloc.add(Bookmark(cardId: widget.revisionCard.card.sId));

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
                                        _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                                        _revisionCardModelBloc.add(Bookmark(cardId: widget.revisionCard.sId));

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
                                      _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                                      _revisionCardModelBloc.add(Bookmark(cardId: widget.revisionCard.card.sId));

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
                                    _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                                    _revisionCardModelBloc.add(Bookmark(cardId: widget.revisionCard.card.sId));

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

                              },
                            ),

                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              )
          ),
          SizedBox(height: 30,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30,),
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {

        // return object of type Dialog
        return BlocProvider<AllRevisionCardModelBloc>(
          create: (context) => AllRevisionCardModelBloc(repository: _repository, ),
          child: AlertDialog(
            title: new Text("Delete?"),
            content: Container(
              height: 60,
              child: BlocBuilder<AllRevisionCardModelBloc, AllRevisionCardModelState>(
                builder: (context, state){
                  if(state is Deleted){
                    if(state.deleteResponse == "card successfully deleted"){
                      revisionCardsBloc.add(Fetch());
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
              BlocBuilder<AllRevisionCardModelBloc, AllRevisionCardModelState>(
                  builder: (context, state){
                    return new FlatButton(
                      child: new Text("Delete"),
                      onPressed: () {
                        _revisionCardModelBloc = BlocProvider.of<AllRevisionCardModelBloc>(context);
                        _revisionCardModelBloc.add(Delete(cardId: widget.revisionCard.card.sId));
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

    await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditCardScreen(repository: _repository, prefs: prefs,cardId: widget.revisionCard.card.sId, cardTitle: widget.revisionCard.card.title, cardContent: widget.revisionCard.card.content, cardParentNodeId: widget.revisionCard.card.parentNode.sId, cardParentNodeTitle: widget.revisionCard.card.parentNode.title,))).then((value){
      revisionCardsBloc.add(Fetch());
    });

  }

}
