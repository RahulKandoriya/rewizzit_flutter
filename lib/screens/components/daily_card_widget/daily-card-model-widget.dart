import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/models/models/card-model.dart';

class DailyCardModelWidget extends StatefulWidget {
  final CardModel cardModel;

  const DailyCardModelWidget({Key key, @required this.cardModel}) : super(key: key);

  @override
  _DailyCardModelWidgetState createState() => _DailyCardModelWidgetState();
}


class _DailyCardModelWidgetState extends State<DailyCardModelWidget> with SingleTickerProviderStateMixin{



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
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("The tiger (Panthera tigris) is the largest species among the Felidae and classified in the genus Panthera. It is most recognisable for its dark vertical stripes on orangish-brown fur with a lighter underside. It is an apex predator, primarily preying on ungulates such as deer and wild boar.",
                  style: GoogleFonts.amaranth(
                    textStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 20,),
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.share,
                  size: 25,
                  color: Colors.grey,
                ),

              ],
            )
          ],
        ),
      )
    );
  }

}
