import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/editCard/editCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCardPage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences prefs;
  final String cardId;
  final String cardTitle;
  final String cardContent;
  final String cardParentNodeId;
  final String cardParentNodeTitle;


  EditCardPage({Key key, @required Repository repository, @required this.prefs, @required this.cardId, @required this.cardTitle, @required this.cardContent, @required this.cardParentNodeId, @required this.cardParentNodeTitle})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _EditCardPageState createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> with SingleTickerProviderStateMixin {

  Repository get _repository => widget._repository;
  SharedPreferences get prefs => widget.prefs;
  String get cardId => widget.cardId;
  String get cardTitle => widget.cardTitle;
  String get cardContent => widget.cardContent;
  String get cardParentNodeId => widget.cardParentNodeId;
  String get cardParentNodeTitle => widget.cardParentNodeTitle;



  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  EditCardBloc _addCardBloc;


  bool get isPopulated =>
      _titleController.text.isNotEmpty && _contentController.text.isNotEmpty;

  bool isSubmitButtonEnabled(EditCardState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }



  @override
  void initState() {
    super.initState();
    _addCardBloc = BlocProvider.of<EditCardBloc>(context);
    _titleController.addListener(_onTitleChanged);
    _titleController.text = cardTitle;
    _contentController.addListener(_onContentChanged);
    _contentController.text = cardContent;
  }



  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Text("Edit Card",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Edit this Card",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50,),
                        BlocListener<EditCardBloc, EditCardState>(
                          listener: (context, state) {
                            if (state.isFailure) {
                              Scaffold.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [Text('Submit Failure'), Icon(Icons.error)],
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                            }
                            if (state.isSubmitting) {
                              Scaffold.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Submitting...'),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                );
                            }
                            if (state.isSuccess) {
                              Navigator.pop(context);
                            }
                          },
                          child: BlocBuilder<EditCardBloc, EditCardState>(
                            builder: (context, state) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 300,
                                    padding: EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 20),
                                    margin: EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 20),
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
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 300,
                                          child: TextFormField(
                                            controller: _titleController,
                                            style: GoogleFonts.amaranth(
                                              textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Title",
                                              hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey[300]),

                                            ),
                                            validator: (_) {
                                              return !state.isTitleValid ? 'Invalid Title' : null;
                                            },

                                          ),
                                        ),
                                        Container(
                                          width: 300,
                                          child: TextFormField(
                                            controller: _contentController,
                                            minLines: 8,
                                            maxLines: 10,
                                            style: GoogleFonts.amaranth(
                                              textStyle: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.normal),
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter Details",
                                              hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey[300]),


                                            ),

                                            validator: (_) {
                                              return !state.isContentValid ? 'Invalid Content' : null;
                                            },
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(width: 20,),
                                            Chip(
                                              backgroundColor: Colors.green,
                                              label: Text(cardParentNodeTitle,
                                                style: TextStyle(fontSize: 15.0, color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: 20,),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: 10,),
                                      Container(
                                        margin: EdgeInsets.only(left: 100, right: 100),
                                        child: RaisedButton(
                                          color: Colors.deepPurple,
                                          onPressed: isSubmitButtonEnabled(state)
                                              ? _onFormSubmitted
                                              : null,
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
                                                  child: Text("Submit",
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
                              );
                            },
                          ),
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
            ],
          ),
        ),
    );
  }


  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();

  }

  void _onTitleChanged() {
    _addCardBloc.add(
      TitleChanged(title: _titleController.text),
    );
  }

  void _onContentChanged() {
    _addCardBloc.add(
      ContentChanged(content: _contentController.text),
    );
  }

  void _onFormSubmitted() {
    _addCardBloc.add(
      SubmitPressed(
        title: _titleController.text,
        content: _contentController.text,
        parentNodeId: cardParentNodeId,
        cardId: cardId,
      ),
    );
  }

}




