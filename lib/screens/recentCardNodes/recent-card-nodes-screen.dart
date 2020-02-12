import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './recent-card-nodes.dart';

class RecentCardNodesScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;

  RecentCardNodesScreen({Key key, @required Repository repository, @required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RecentCardNodesBloc>(
        create: (context) => RecentCardNodesBloc(repository: _repository)..add(Fetch()),
        child: RecentCardNodesPage(repository: _repository, prefs: prefs,),
      ),
    );
  }
}