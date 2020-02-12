import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RevisionCompleteScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 60,),
                Expanded(
                  child: FlareActor("assets/images/success.flr", alignment:Alignment.center, fit:BoxFit.fitHeight, animation:"check-success"),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 60,),
                  Center(
                    child:  Text("Revision\nCompleted!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 35, color: Colors.brown, fontWeight: FontWeight.bold, wordSpacing: 10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}