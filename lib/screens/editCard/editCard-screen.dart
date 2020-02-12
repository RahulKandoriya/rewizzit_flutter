import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/editCard/editCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCardScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;
  final String cardId;
  final String cardTitle;
  final String cardContent;
  final String cardParentNodeId;
  final String cardParentNodeTitle;

  EditCardScreen({Key key, @required Repository repository, @required this.prefs, @required this.cardId, @required this.cardTitle, @required this.cardContent, @required this.cardParentNodeId, @required this.cardParentNodeTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EditCardBloc>(
        create: (context) => EditCardBloc(repository: _repository),
        child: EditCardPage(repository: _repository, prefs: prefs, cardId: cardId, cardTitle: cardTitle, cardContent: cardContent, cardParentNodeTitle: cardParentNodeTitle, cardParentNodeId: cardParentNodeId,),
      ),
    );
  }
}