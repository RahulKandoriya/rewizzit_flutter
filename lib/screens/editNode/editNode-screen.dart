import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './editNode.dart';

class EditNodeScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;
  final String parentNodeId;
  final String parentNodeTitle;

  EditNodeScreen({Key key, @required Repository repository, @required this.prefs, @required this.parentNodeId, @required this.parentNodeTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EditNodeBloc>(
        create: (context) => EditNodeBloc(repository: _repository),
        child: EditNodePage(repository: _repository, prefs: prefs, parentNodeId: parentNodeId, parentNodeTitle: parentNodeTitle,),
      ),
    );
  }
}