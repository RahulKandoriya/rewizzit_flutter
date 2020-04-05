import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:url_launcher/url_launcher.dart';


class AboutScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              title: Text("About",
                style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Container(
              margin: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only( top: 40, bottom: 40, left: 20),
                    child: Text("Rewizzit is an app for students to make Organising, Reading and Revising Easy.",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _launchTermsURL,
                        child: Chip(
                          backgroundColor: Colors.green,
                          label: Text("Terms and Conditions",
                            style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: _launchURL,
                        child: Chip(
                          backgroundColor: Colors.green,
                          label: Text("Privacy Policy",
                            style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://bit.ly/rewizzit-policy';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchTermsURL() async {
  const url = 'https://bit.ly/rewizzit-terms';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}