import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addNode/addNode.dart';
import 'package:rewizzit/screens/components/add-card-widget/add-card-model-widget.dart';
import 'package:rewizzit/screens/components/add-node-widget/add-node-model-widget.dart';
import 'package:zefyr/zefyr.dart';

class AddNodePage extends StatefulWidget {

  final Repository _repository;

  AddNodePage({Key key, @required Repository repository})
      : assert(repository != null),
        _repository = repository, super(key: key);


  @override
  _AddNodePageState createState() => _AddNodePageState();
}

class _AddNodePageState extends State<AddNodePage> with SingleTickerProviderStateMixin {


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
                        Text("Add Node",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Subjet | Chapter | Anything",
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: BlocBuilder<AddNodeBloc, AddNodeState>(
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
                            return AddNodeModelWidget();
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}




