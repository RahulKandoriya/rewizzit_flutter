import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/collections/collections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionsScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;

  CollectionsScreen({Key key, @required Repository repository, @required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CollectionsBloc>(
        create: (context) => CollectionsBloc(repository: _repository)..add(Fetch()),
        child: CollectionsPage(repository: _repository, prefs: prefs,),
      ),
    );
  }
}