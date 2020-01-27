import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:rewizzit/screens/addCard/addCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCardScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;

  AddCardScreen({Key key, @required Repository repository, @required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddCardBloc>(
        create: (context) => AddCardBloc(repository: _repository),
        child: AddCardPage(repository: _repository, prefs: prefs,),
      ),
    );
  }
}