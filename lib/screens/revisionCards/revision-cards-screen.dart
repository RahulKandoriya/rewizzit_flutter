import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/revisionCards/bloc/bloc.dart';
import 'package:rewizzit/screens/revisionCards/revision-cards-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevisionCardsScreen extends StatelessWidget {

  final Repository repository;
  final int cardPosition;
  final SharedPreferences prefs;

  RevisionCardsScreen({Key key, @required this.repository, @required this.cardPosition, @required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RevisionCardsBloc>(
        create: (context) => RevisionCardsBloc(repository: repository)..add(Fetch()),
        child: RevisionCardsPage(repository: repository, cardPosition: cardPosition, prefs: prefs,),
      ),
    );
  }
}