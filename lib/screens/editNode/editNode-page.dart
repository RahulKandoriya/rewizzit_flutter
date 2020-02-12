import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './editNode.dart';

class EditNodePage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences prefs;
  final String parentNodeId;
  final String parentNodeTitle;

  EditNodePage({Key key, @required Repository repository, @required this.prefs, @required this.parentNodeId, @required this.parentNodeTitle})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _EditNodePageState createState() => _EditNodePageState();
}

class _EditNodePageState extends State<EditNodePage> with SingleTickerProviderStateMixin {


  Repository get _repository => widget._repository;
  SharedPreferences get prefs => widget.prefs;
  String get parentNodeId => widget.parentNodeId;
  String get parentNodeTitle => widget.parentNodeTitle;

  final TextEditingController _titleController = TextEditingController();


  EditNodeBloc _addNodeBloc;


  bool get isPopulated =>
      _titleController.text.isNotEmpty;

  bool isSubmitButtonEnabled(EditNodeState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool isCardNode = false;

  FocusNode _focusNode;


  @override
  void initState() {
    _addNodeBloc = BlocProvider.of<EditNodeBloc>(context);
    _titleController.addListener(_onTitleChanged);
    _titleController.text = parentNodeTitle;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 50,),
                        Text("Edit Node",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Edit this Node",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                          ),
                        ),
                        SizedBox(height: 30,),
                        BlocListener<EditNodeBloc, EditNodeState>(
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
                          child: BlocBuilder<EditNodeBloc, EditNodeState>(
                            builder: (context, state) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: Container(
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
                                        child: Container(
                                          margin: EdgeInsets.only(left: 25, right: 25),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child: TextFormField(
                                                  maxLength: 25,
                                                  style: GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter Title",
                                                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey[300]),

                                                  ),
                                                  focusNode: _focusNode,
                                                  autofocus: true,
                                                  controller: _titleController,
                                                  validator: (_) {
                                                    return !state.isTitleValid ? 'Invalid Title' : null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 50,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
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
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTitleChanged() {
    _addNodeBloc.add(
      TitleChanged(title: _titleController.text),
    );
  }

  void _onFormSubmitted() {
    _addNodeBloc.add(
      SubmitPressed(
        title: _titleController.text,
        parentNodeId: parentNodeId,
      ),
    );
  }


}




