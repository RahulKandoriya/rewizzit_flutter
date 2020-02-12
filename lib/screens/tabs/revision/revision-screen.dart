import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/tabs/revision/revision.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevisionScreen extends StatelessWidget {

  final Repository repository = Repository();
  final SharedPreferences preferences;

  RevisionScreen({Key key,@required this.preferences,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RevisionBloc>(
        create: (context) => RevisionBloc(repository: repository)..add(FetchRevisionControls()),
        child: RevisionPage(repository: repository, preference: preferences),
      ),
    );
  }
}