import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/allRevisionCards/bloc/bloc.dart';
import 'package:rewizzit/screens/allRevisionCards/all-revision-cards-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllRevisionCardsScreen extends StatelessWidget {

  final Repository repository;
  final int cardPosition;
  final SharedPreferences prefs;

  AllRevisionCardsScreen({Key key, @required this.repository, @required this.cardPosition, @required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AllRevisionCardsBloc>(
        create: (context) => AllRevisionCardsBloc(repository: repository)..add(Fetch()),
        child: AllRevisionCardsPage(repository: repository, cardPosition: cardPosition, prefs: prefs,),
      ),
    );
  }
}