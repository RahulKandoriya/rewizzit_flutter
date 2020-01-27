import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/models/models/card-model.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/editCard/editCard-screen.dart';

class NodeCardModelWidget extends StatefulWidget {
  final CardModel cardModel;

  const NodeCardModelWidget({Key key, @required this.cardModel}) : super(key: key);

  @override
  _NodeCardModelWidgetState createState() => _NodeCardModelWidgetState();
}


class _NodeCardModelWidgetState extends State<NodeCardModelWidget> with SingleTickerProviderStateMixin{


  Repository _repository = Repository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.loop,
                    size: 25,
                    color: Colors.grey,
                  ),
                  onPressed: () {

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
                IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    size: 25,
                    color: Colors.grey,
                  ),
                  onPressed: () {

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
            )
          ],
        ),
      )
    );
  }

}
