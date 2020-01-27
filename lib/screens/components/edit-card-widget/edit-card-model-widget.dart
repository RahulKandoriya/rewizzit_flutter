import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';
import 'package:rewizzit/screens/nodesPage/nodes-screen.dart';
import 'package:zefyr/zefyr.dart';

class EditCardModelWidget extends StatefulWidget {

  const EditCardModelWidget({Key key,}) : super(key: key);

  @override
  _EditCardModelWidgetState createState() => _EditCardModelWidgetState();
}


class _EditCardModelWidgetState extends State<EditCardModelWidget> with SingleTickerProviderStateMixin{

  final Repository _repository = Repository();

  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    final document = NotusDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode(
      canRequestFocus: true
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
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
          margin: EdgeInsets.only(left: 25, top: 10, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 300,
                child: TextField(
                  maxLength: 20,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Title",
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey[300]),

                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  maxLength: 300,
                  minLines: 9,
                  maxLines: 10,
                  style: GoogleFonts.josefinSans(
                    textStyle: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.normal),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Details",
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey[300]),


                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20,),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NodesScreen(repository: _repository)));
                    },
                    child: Chip(
                      backgroundColor: Colors.green,
                      label: Text('Add Node',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),

                ],
              )
            ],
          ),
        )
    );
  }

  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    return NotusDocument.fromDelta(delta);
  }

}
