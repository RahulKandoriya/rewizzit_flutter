import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/recentCards/recent-cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentCardsScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;
  final int cardPosition;

  RecentCardsScreen({Key key, @required Repository repository, @required this.prefs, @required this.cardPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RecentCardsBloc>(
        create: (context) => RecentCardsBloc(repository: _repository)..add(Fetch()),
        child: RecentCardsPage(repository: _repository, prefs: prefs, cardPosition: cardPosition,),
      ),
    );
  }
}