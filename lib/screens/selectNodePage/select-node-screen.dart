import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './select-node.dart';

class SelectNodeScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;

  SelectNodeScreen({Key key, @required Repository repository, @required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SelectNodeBloc>(
        create: (context) => SelectNodeBloc(repository: _repository)..add(Fetch(parentNodeId: "5e16f2fb8cc29a2feb748391")),
        child: SelectNodePage(repository: _repository, prefs: prefs),
      ),
    );
  }
}