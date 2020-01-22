import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/recentCards/recent-cards.dart';

class RecentCardsScreen extends StatelessWidget {

  final Repository _repository = Repository();

  RecentCardsScreen({Key key, @required Repository repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RecentCardsBloc>(
        create: (context) => RecentCardsBloc(repository: _repository)..add(Fetch()),
        child: RecentCardsPage(repository: _repository),
      ),
    );
  }
}