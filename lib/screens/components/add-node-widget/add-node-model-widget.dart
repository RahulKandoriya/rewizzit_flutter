import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/nodeCards/node-cards-screen.dart';
import 'package:rewizzit/screens/nodesPage/nodes-screen.dart';
import 'package:zefyr/zefyr.dart';

class AddNodeModelWidget extends StatefulWidget {

  const AddNodeModelWidget({Key key,}) : super(key: key);

  @override
  _AddNodeModelWidgetState createState() => _AddNodeModelWidgetState();
}


class _AddNodeModelWidgetState extends State<AddNodeModelWidget> with SingleTickerProviderStateMixin{

  final Repository _repository = Repository();

  bool switchOn = false;
  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  void _onSwitchChanged(bool value) {
    switchOn = value;
  }


  @override
  void initState() {
    super.initState();
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
          margin: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextField(
                  maxLength: 25,
                  style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  focusNode: _focusNode,
                  autofocus: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: switchOn,
                    onChanged: (bool value) {
                      setState(() {
                        switchOn = value;
                      });
                    },
                  ),
                  SizedBox(width: 10,),
                  Text("Is Card Node",
                    style: GoogleFonts.josefinSans(
                      textStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }



}
