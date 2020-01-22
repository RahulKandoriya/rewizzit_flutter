import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/models/models/user.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/tabs/account/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rewizzit/authentication_bloc/bloc.dart';

class AccountPage extends StatefulWidget {

  final Repository _repository;
  final SharedPreferences preference;

  AccountPage({Key key, @required Repository repository, @required this.preference})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin {

  Repository get _repository => widget._repository;

  SharedPreferences get preference => widget.preference;

  TabController controller;


  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }


  @override
  Widget build(BuildContext context) {


    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.grey[200],
          expandedHeight: 80.0,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 200,
                child: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 20.0, bottom: 15.0),
                    title: Text("Me",
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(FontAwesome.sign_out),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    LoggedOut(),
                  );
                },
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
        BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: Chip(
                          backgroundColor: Colors.green,
                          label: Text("FREE TIER",
                            style: TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(User.fromJson(json.decode(preference.getString("user"))).uPicture)
                                    )
                                )),
                            SizedBox(height: 50),
                            Text(User.fromJson(json.decode(preference.getString("user"))).uName,
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(User.fromJson(json.decode(preference.getString("user"))).uEmail,
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 50,),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        color: Colors.purple,
                        gradient: new LinearGradient(
                            colors: [Colors.purple, Colors.lightBlue[200]],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                        ),
                        borderRadius: new BorderRadius.circular(25.0),                        ),
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("Read Easily\nOrganise Well\nRevise Effectivly",
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal, height: 1.5),
                                  ),
                                ),
                              )
                          ),
                          Spacer(),
                          Center(
                            child: Icon(
                              Icons.lightbulb_outline,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 30),
                        ],

                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: RaisedButton(
                        color: Colors.deepPurple,
                        onPressed: () {

                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.lock_open,
                                size: 25,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Unlock Full Access",
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
                    SizedBox(height: 150,),

                  ],
                )
              /// Set childCount to limit no.of items
              /// childCount: 100,
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}


