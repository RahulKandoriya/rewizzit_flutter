import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import './addCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCardFromNodeScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;
  final String parentNodeId;
  final String parentNodeTitle;

  AddCardFromNodeScreen({Key key, @required Repository repository, @required this.prefs, @required this.parentNodeId, @required this.parentNodeTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddCardBloc>(
        create: (context) => AddCardBloc(repository: _repository),
        child: AddCardPage(repository: _repository, prefs: prefs, parentNodeTitle: parentNodeTitle, parentNodeId: parentNodeId,),
      ),
    );
  }
}