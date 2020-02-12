import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addNode/addNode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNodeScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;
  final String parentNodeId;


  AddNodeScreen({Key key, @required Repository repository,  @required this.prefs, @required this.parentNodeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddNodeBloc>(
        create: (context) => AddNodeBloc(repository: _repository),
        child: AddNodePage(repository: _repository, prefs: prefs, parentNodeId: parentNodeId,),
      ),
    );
  }
}