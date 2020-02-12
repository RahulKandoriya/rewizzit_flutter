import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/dailyCards/daily-cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyCardsScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;

  DailyCardsScreen({Key key, @required Repository repository, @required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DailyCardsBloc>(
        create: (context) => DailyCardsBloc(repository: _repository)..add(Fetch()),
        child: DailyCardsPage(repository: _repository, prefs: prefs,),
      ),
    );
  }
}