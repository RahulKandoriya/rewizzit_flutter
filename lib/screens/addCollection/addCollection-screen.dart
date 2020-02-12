import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewizzit/data/services/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './addCollection.dart';

class AddCollectionScreen extends StatelessWidget {

  final Repository _repository = Repository();
  final SharedPreferences prefs;


  AddCollectionScreen({Key key, @required Repository repository, @required this.prefs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddCollectionBloc>(
        create: (context) => AddCollectionBloc(repository: _repository),
        child: AddCollectionPage(repository: _repository, prefs: prefs,),
      ),
    );
  }
}