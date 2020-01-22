import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCard/addCard.dart';
import 'package:rewizzit/screens/components/add-card-widget/add-card-model-widget.dart';
import 'package:zefyr/zefyr.dart';

class AddCardPage extends StatefulWidget {

  final Repository _repository;

  AddCardPage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> with SingleTickerProviderStateMixin {


  Repository get _repository => widget._repository;



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Container(
          height: double.infinity,
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
                            Text("Add Card",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Make note card",
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50,),
                        Container(
                          height: 420,
                          width: double.infinity,
                          child: BlocBuilder<AddCardBloc, AddCardState>(
                            builder: (context, state) {
                              if (state is Failure) {
                                return Center(
                                  child: Text('failed to fetch posts'),
                                );
                              }
                              if (state is Loaded) {
                                if (state.bookmarkCards.isEmpty) {
                                  return Center(
                                    child: Text('no posts'),
                                  );
                                }
                                return AddCardModelWidget();
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
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
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 30),
                      child: Icon(
                          Icons.close
                      ),
                    ),
                  )
                ],
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

}




